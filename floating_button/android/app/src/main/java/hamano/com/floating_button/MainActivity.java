package hamano.com.floating_button;

import android.os.Bundle;
import android.widget.ImageView;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.yhao.floatwindow.FloatWindow;
import com.yhao.floatwindow.Screen;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "floating_button";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        MethodChannel channel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);

        channel.setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "create":
                    ImageView imageView = new ImageView(getApplicationContext());
                    imageView.setImageResource(R.drawable.plus);

                    FloatWindow.with(getApplicationContext()).setView(imageView)
                            .setWidth(Screen.width, 0.15f)
                            .setHeight(Screen.width, 0.15f)
                            .setX(Screen.width, 0.8f)
                            .setY(Screen.width, 0.8f)
                            .setDesktopShow(true)
                            .build();

                    imageView.setOnClickListener(v -> {
                        channel.invokeMethod("touch", null);
                    });
                    break;
                case "show":
                    FloatWindow.get().show();
                    break;
                case "hide":
                    FloatWindow.get().hide();
                    break;
                case "isShowing":
                    result.success(FloatWindow.get().isShowing());
                    break;
                default:
                    result.notImplemented();
                    break;
            }
        });
    }

    @Override
    protected void onDestroy() {
        FloatWindow.destroy();
        super.onDestroy();
    }
}

