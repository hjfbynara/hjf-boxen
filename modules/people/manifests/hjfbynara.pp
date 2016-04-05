class people::hjfbynara {
    include brewcask
    include chrome
    include cord
#    include cyberduck
    include docker_toolbox
    include dockutil
    include dropbox
    include firefox
    include fish
#    include fitbit
    include googledrive
    include hipchat
    include iterm2::stable
#    include jumpcut
#    include pivotalbooster
#    include robomongo
    include sequel_pro
#    include shiftit
#    include spotify
    include sublime_text::v2
    include vagrant
    include wget
    include onepassword
    include onepassword::chrome

#    include libreoffice
#    class { 'libreoffice':
#     version => '5.0.4',
#    }

#    include libreoffice::languagepack
#    class { 'libreoffice::languagepack':
#      locale => 'en-US',
#    }


    $sublimeConfDir = "/Users/${::luser}/Library/Application Support/Sublime Text 2"
    $structure = [ "${sublimeConfDir}", "${sublimeConfDir}/Packages" ]

    file { $structure:
        ensure  => 'directory',
        owner   => "${::luser}",
        mode    => '0755'
    }->
    file { "${sublimeConfDir}/Packages/User/Preferences.sublime-settings":
      content  => '
{
    "color_scheme": "Packages/Color Scheme - Default/Sunburst.tmTheme",
    "font_size": 12.0,
    "trim_trailing_white_space_on_save": true,
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "ignored_packages":
    [
        "Vintage"
    ]
}'
    }

    $dockitems = hiera_hash('dockitems', {})
    create_resources('dockutil::item', $dockitems)

    $rubygems = hiera_hash('rubygems', {})
    create_resources('ruby_gem', $rubygems)

    # Homebrew: Apps.....
    package {[
        'cowsay',
        'docker',
        'docker-machine',
        'figlet',
        'graphviz',
        'gnuplot',
        'netcat',
        'socat',
        'jq',
        'vault'
    ]:
    }

    # Homebrew: Cask (GUI) Apps.....
    package {[
#        'tinkertool',
        'google-cloud-sdk',
        'java',
#        'seashore',
    ]:
        provider => 'brewcask',
    }

    include osx::global::enable_keyboard_control_access
    include osx::finder::unhide_library
    include osx::global::expand_save_dialog

#    osx::dock::hot_corner { 'Bottom Right':
#        action => 'Start Screen Saver'
#    }
#    osx::dock::hot_corner { 'Bottom Left':
#        action => 'Disable Screen Saver'
#    }

#    class {'osx::global::natural_mouse_scrolling':
#        enabled => false
#    }
}
