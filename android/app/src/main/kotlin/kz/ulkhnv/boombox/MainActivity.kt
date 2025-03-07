package kz.ulkhnv.boombox

import android.content.Context
import android.database.ContentObserver
import android.media.AudioManager
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val EVENT_CHANNEL = "boombox/volume_stream"
    private var eventSink: EventChannel.EventSink? = null
    private lateinit var audioManager: AudioManager
    private lateinit var volumeObserver: ContentObserver

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    sendVolumeUpdate()
                    startListeningVolumeChanges()
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    stopListeningVolumeChanges()
                }
            }
        )
    }

    private fun startListeningVolumeChanges() {
        volumeObserver = object : ContentObserver(Handler(Looper.getMainLooper())) {
            override fun onChange(selfChange: Boolean) {
                super.onChange(selfChange)
                sendVolumeUpdate()
            }
        }
        contentResolver.registerContentObserver(
            android.provider.Settings.System.CONTENT_URI,
            true,
            volumeObserver
        )
    }

    private fun stopListeningVolumeChanges() {
        contentResolver.unregisterContentObserver(volumeObserver)
    }

    private fun sendVolumeUpdate() {
        val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
        eventSink?.success(currentVolume)
    }
}
