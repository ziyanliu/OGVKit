Pod::Spec.new do |s|
  s.name         = "OGVKit"
  s.version      = "0.5.13"
  s.summary      = "Ogg Vorbis/Theora and WebM media playback widget for iOS."

  s.description  = <<-DESC
                   Ogg Vorbis/Theora and WebM media playback widget for iOS.
                   Packages Xiph.org's libogg, libvorbis, and libtheora, and
                   uses Google's VPX library, along with a UIView subclass
                   to play a video or audio file from a URL.
                   DESC

  s.homepage     = "https://github.com/brion/OGVKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Brion Vibber" => "brion@pobox.com" }
  s.social_media_url   = "https://brionv.com/"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/brion/OGVKit.git",
                     :tag => s.version,
                     :submodules => true }

  s.header_dir = 'OGVKit'
  s.module_name = 'OGVKit'

  s.subspec "Core" do |score|
    score.source_files = "Classes/OGVKit.{h,m}",
                         "Classes/OGVLogger.{h,m}",
                         "Classes/OGVQueue.{h,m}",
                         "Classes/OGVMediaType.{h,m}",
                         "Classes/OGVAudioFormat.{h,m}",
                         "Classes/OGVAudioBuffer.{h,m}",
                         "Classes/OGVVideoFormat.{h,m}",
                         "Classes/OGVVideoPlane.{h,m}",
                         "Classes/OGVVideoBuffer.{h,m}",
                         "Classes/OGVHTTPContentRange.{h,m}",
                         "Classes/OGVInputStream.{h,m}",
                         "Classes/OGVDataInputStream.{h,m}",
                         "Classes/OGVFileInputStream.{h,m}",
                         "Classes/OGVHTTPInputStream.{h,m}",
                         "Classes/OGVDecoder.{h,m}",
                         "Classes/OGVFrameView.{h,m}",
                         "Classes/OGVAudioFeeder.{h,m}",
                         "Classes/OGVPlayerState.{h,m}",
                         "Classes/OGVPlayerView.{h,m}"

    score.public_header_files = "Classes/OGVKit.h",
                                "Classes/OGVQueue.h",
                                "Classes/OGVLogger.h",
                                "Classes/OGVMediaType.h",
                                "Classes/OGVAudioFormat.h",
                                "Classes/OGVAudioBuffer.h",
                                "Classes/OGVVideoFormat.h",
                                "Classes/OGVVideoPlane.h",
                                "Classes/OGVVideoBuffer.h",
                                "Classes/OGVInputStream.h",
                                "Classes/OGVDecoder.h",
                                "Classes/OGVFrameView.h",
                                "Classes/OGVAudioFeeder.h",
                                "Classes/OGVPlayerState.h",
                                "Classes/OGVPlayerView.h"

    score.resource_bundle = {
      'OGVKitResources' => [
        'Resources/OGVFrameView.fsh',
        'Resources/OGVFrameView.vsh',
        'Resources/OGVPlayerView.xib',
        'Resources/ogvkit-iconfont.ttf'
      ]
    }
  end

  # File format convenience subspecs
  s.subspec "Ogg" do |sogg|
    sogg.subspec "Theora" do |soggtheora|
      soggtheora.dependency 'OGVKit/OggDemuxer'
      soggtheora.dependency 'OGVKit/TheoraDecoder'
      soggtheora.dependency 'OGVKit/VorbisDecoder'
    end
    sogg.subspec "Vorbis" do |soggvorbis|
      soggvorbis.dependency 'OGVKit/OggDemuxer'
      soggvorbis.dependency 'OGVKit/VorbisDecoder'
    end
    sogg.subspec "Opus" do |soggopus|
      soggopus.dependency 'OGVKit/OggDemuxer'
      soggopus.dependency 'OGVKit/OpusDecoder'
    end
  end
  s.subspec "WebM" do |swebm|
    swebm.subspec "VP8" do |swebmvp8|
      swebmvp8.dependency 'OGVKit/WebMDemuxer'
      swebmvp8.dependency 'OGVKit/VP8Decoder'
      swebmvp8.dependency 'OGVKit/VorbisDecoder'
    end
    swebm.subspec "Vorbis" do |swebmvorbis|
      swebmvorbis.dependency 'OGVKit/WebMDemuxer'
      swebmvorbis.dependency 'OGVKit/VorbisDecoder'
    end
    swebm.subspec "Opus" do |swebmopus|
      swebmopus.dependency 'OGVKit/WebMDemuxer'
      swebmopus.dependency 'OGVKit/OpusDecoder'
    end
  end
  s.subspec "MP4" do |smp4|
    smp4.dependency 'OGVKit/AVDecoder'
  end
  s.subspec "MP3" do |smp4|
    smp4.dependency 'OGVKit/AVDecoder'
  end

  # Demuxer module subspecs
  s.subspec "OggDemuxer" do |soggdemuxer|
    soggdemuxer.source_files = "Classes/OGVDecoderOgg.{h,m}",
                               "Classes/OGVDecoderOggPacket.{h,m}"
    soggdemuxer.private_header_files = "Classes/OGVDecoderOgg.h",
                                       "Classes/OGVDecoderOggPacket.h"
    soggdemuxer.dependency 'OGVKit/Core'
    soggdemuxer.dependency 'liboggz', :git => 'https://gitlab.xiph.org/xiph/liboggz.git', :tag => '1.2.0-1'
    soggdemuxer.dependency 'OGVKit/libskeleton', '~>0.4'
  end
  s.subspec "WebMDemuxer" do |swebmdemuxer|
    swebmdemuxer.source_files = "Classes/OGVDecoderWebM.{h,m}",
                                "Classes/OGVDecoderWebMPacket.{h,m}"
    swebmdemuxer.private_header_files = "Classes/OGVDecoderWebM.h",
                                        "Classes/OGVDecoderWebMPacket.h"
    swebmdemuxer.dependency 'OGVKit/Core'
    swebmdemuxer.dependency 'libnestegg', '~>0.2'
  end

  # Video decoder module subspecs
  s.subspec "TheoraDecoder" do |stheoradecoder|
    stheoradecoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_THEORA_DECODER' }
    stheoradecoder.dependency 'OGVKit/Core'
    stheoradecoder.dependency 'libtheora', '1.2.0-3'
  end
  s.subspec "VP8Decoder" do |svp8decoder|
    svp8decoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_VP8_DECODER' }
    svp8decoder.dependency 'OGVKit/Core'
    svp8decoder.dependency 'libvpx', '~>1.7.0'
  end

  # Audio decoder module subspecs
  s.subspec "VorbisDecoder" do |svorbisdecoder|
    svorbisdecoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_VORBIS_DECODER' }
    svorbisdecoder.dependency 'OGVKit/Core'
    svorbisdecoder.dependency 'libvorbis'
  end
  s.subspec "OpusDecoder" do |sopusdecoder|
    sopusdecoder.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_OPUS_DECODER'  }
    sopusdecoder.dependency 'OGVKit/Core'
    sopusdecoder.dependency 'libopus'
    sopusdecoder.source_files = "opus-tools/src/opus_header.h",
                                "opus-tools/src/opus_header.c"
  end

  # AVFoundation-backed playback for MP4, MP3
  s.subspec "AVDecoder" do |savdecoder|
    savdecoder.dependency 'OGVKit/Core'
    savdecoder.source_files = "Classes/OGVDecoderAV.{h,m}"
    savdecoder.private_header_files = "Classes/OGVDecoderAV.h"
  end

  s.subspec "Encoder" do |sencoder|
    sencoder.dependency "OGVKit/WebMEncoder"
  end

  s.subspec "WebMEncoder" do |swebmenc|
    swebmenc.dependency "OGVKit/VorbisEncoder"
    swebmenc.dependency "OGVKit/VP8Encoder"
    swebmenc.dependency "OGVKit/WebMMuxer"
  end

  s.subspec "EncoderCore" do |scoreenc|
    scoreenc.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_ENCODER' }
    scoreenc.source_files = "Classes/OGVPacket.h",
                            "Classes/OGVPacket.m",
                            "Classes/OGVMuxer.h",
                            "Classes/OGVMuxer.m",
                            "Classes/OGVOutputStream.h",
                            "Classes/OGVOutputStream.m",
                            "Classes/OGVFileOutputStream.h",
                            "Classes/OGVFileOutputStream.m",
                            "Classes/OGVAudioEncoder.h",
                            "Classes/OGVAudioEncoder.m",
                            "Classes/OGVVideoEncoder.h",
                            "Classes/OGVVideoEncoder.m",
                            "Classes/OGVEncoder.h",
                            "Classes/OGVEncoder.m"
    scoreenc.public_header_files = "Classes/OGVPacket.h",
                                   "Classes/OGVMuxer.h",
                                   "Classes/OGVOutputStream.h",
                                   "Classes/OGVFileOutputStream.h",
                                   "Classes/OGVAudioEncoder.h",
                                   "Classes/OGVVideoEncoder.h",
                                   "Classes/OGVEncoder.h"
  end

  s.subspec "VorbisEncoder" do |svorbisenc|
    svorbisenc.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_VORBIS_ENCODER' }
    svorbisenc.dependency 'OGVKit/EncoderCore'
    svorbisenc.source_files = "Classes/OGVVorbisEncoder.h",
                              "Classes/OGVVorbisEncoder.m"
  end

  s.subspec "VP8Encoder" do |svp8enc|
    svp8enc.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_VP8_ENCODER' }
    svp8enc.dependency 'OGVKit/EncoderCore'
    svp8enc.source_files = "Classes/OGVVP8Encoder.h",
                           "Classes/OGVVP8Encoder.m"
  end

  s.subspec "WebMMuxer" do |swebmmux|
    swebmmux.xcconfig = { 'OTHER_CFLAGS' => '-DOGVKIT_HAVE_WEBM_MUXER' }
    swebmmux.dependency 'OGVKit/EncoderCore'
    swebmmux.dependency 'WebM'
    swebmmux.source_files = "Classes/OGVWebMMuxer.h",
                            "Classes/OGVWebMMuxer.mm"
  end

  # Additional libraries not ready to package separately
  s.subspec "libskeleton" do |sskel|
    sskel.source_files = "libskeleton/include/skeleton/skeleton.h",
                         "libskeleton/include/skeleton/skeleton_constants.h",
                         "libskeleton/include/skeleton/skeleton_query.h",
                         "libskeleton/src/skeleton.c",
                         "libskeleton/src/skeleton_macros.h",
                         "libskeleton/src/skeleton_private.h",
                         "libskeleton/src/skeleton_query.c",
                         "libskeleton/src/skeleton_vector.h",
                         "libskeleton/src/skeleton_vector.c"
    sskel.compiler_flags = "-Wno-conversion",
                           "-Wno-unused-function"

    sskel.public_header_files = "libskeleton/include/skeleton/skeleton.h",
                                "libskeleton/include/skeleton/skeleton_constants.h",
                                "libskeleton/include/skeleton/skeleton_query.h"

    sskel.dependency 'libogg'
  end

end
