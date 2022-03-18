#!/bin/ruby

# FLATPACK_DIR="/var/lib/flatpak/exports/bin"
# APPLICATION_DIR="/usr/share/applications"
#
# while [ "$1" != "" ]
# do
#     case "$1" in
#         -s | --search | -l | --list)
#             if [ "$2" = "" ]
#             then
#                 echo -e "${RED}ERROR: No parameter given ${NC}"
#                 exit
#             fi
#             KERNEL=$2
#             echo kernel = $KERNEL
#             shift 2
#             ;;
#         -r | --run)
#             DESKTOP=$(echo 0)
#             shift
#             ;;
#         *)
#             echo "help message"
#             shift
#             ;;
#     esac
# done
# paths=$(locate .desktop)
# # tail $paths
# mimes=$(xdg-mime query filetype $paths)
#
#
# echo $mimes
#
#
# # nohup $1 > /dev/null & exit 0
# # launch=$($application_path & disown)
#
# search_apt () {
#
# }
#
# search_flatpak () {
#
# }
#
# search_desktop_applications () {
#
# }


out = `locate .desktop`

desktop_files = out.split("\n")
puts out.class
puts desktop_files.class
puts desktop_files.count
desktop_files.each do |path|
    command = "xdg-mime query filetype #{path}"
    a = system(command)
    puts a 
    if Dir.exists?(path)
        puts "directory"
        next
    end
    file = File.foreach(path) do |line|
        begin
            line_array = line.split " "
            if line_array.include?("exec")
                puts "line"
            end
        rescue => e
            puts e
        end
    end
end
#
