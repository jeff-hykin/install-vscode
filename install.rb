require 'atk_toolbox'


# if the vs code command doesn't exist
if not Console.has_command("code")
    # pick an operating system
    if OS.is?('mac')
        # overwrite all system links for python2 encase anything was broken from previous installs
        -"brew cask install visual-studio-code"
    elsif OS.is?('windows')
        -"scoop install vscode"
    elsif OS.is?('linux')
        if OS.is?('ubuntu')
            version = OS.version
            should_install = false
            if version.major == 16 || version.major == 18
                should_install = true
            else
                should_install = Console.ask <<-HEREDOC.remove_indent
                    This script is only setup for Ubuntu 18 and 16
                    Would you like to try and use the Ubuntu 18/16 installer
                    even though you're not on Ubuntu 18/16?
                HEREDOC
            end
            
            if not should_install
                raise "Visual Studio Code not installed. Please install it manually".red
            else
                -"yes | sudo apt update"
                -"yes | sudo apt install software-properties-common apt-transport-https wget"
                -"wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -"
                -"yes | sudo add-apt-repository \"deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main\""
                -"yes | sudo apt update"
                -"yes | sudo apt install code"
            end
        else
            raise <<-HEREDOC.remove_indent.red
                
                
                The auto installer for VS Code doesn't yet support your OS
                Please install Visual Studio Code manually
            HEREDOC
        end
    end
end
puts "VS Code should now be installed"