#!/usr/bin/env bash
# Master script to create and manage all process and signals task files

echo "Starting process_and_signals.sh master script..."
echo "=========================================="
echo "Working in directory: $(pwd)"

# Function to create script file, make it executable, and commit
create_and_commit_script() {
    local filename="$1"
    local content="$2"
    
    echo "Creating script: $filename"
    echo "$content" > "$filename"
    chmod +x "$filename"
    git add .
    git commit -m "add $filename"
    echo "✓ Created and committed: $filename"
    echo ""
}

# Task 6: Stop me if you can
echo "Processing Task 6: Stop me if you can"

task6_content='#!/usr/bin/env bash
# Script that stops 4-to_infinity_and_beyond process without using kill or killall

# Find the PID of the 4-to_infinity_and_beyond process
pid=$(pgrep -f "4-to_infinity_and_beyond")

if [ -n "$pid" ]; then
    # Send SIGTERM signal to the process
    pkill -f "4-to_infinity_and_beyond"
fi'

create_and_commit_script "6-stop_me_if_you_can" "$task6_content"

# Task 7: Highlander
echo "Processing Task 7: Highlander"

task7_content='#!/usr/bin/env bash
# Script that displays "To infinity and beyond" indefinitely
# Displays "I am invincible!!!" when receiving SIGTERM signal

# Function to handle SIGTERM signal
handle_sigterm() {
    echo "I am invincible!!!"
}

# Set up signal handler
trap handle_sigterm SIGTERM

# Infinite loop
while true; do
    echo "To infinity and beyond"
    sleep 2
done'

create_and_commit_script "7-highlander" "$task7_content"

# Task 7 additional: 67-stop_me_if_you_can (copy of task 6 but for 7-highlander)
task67_content='#!/usr/bin/env bash
# Script that stops 7-highlander process without using kill or killall

# Find the PID of the 7-highlander process
pid=$(pgrep -f "7-highlander")

if [ -n "$pid" ]; then
    # Send SIGTERM signal to the process
    pkill -f "7-highlander"
fi'

create_and_commit_script "67-stop_me_if_you_can" "$task67_content"

# Task 8: Beheaded process
echo "Processing Task 8: Beheaded process"

task8_content='#!/usr/bin/env bash
# Script that kills the 7-highlander process

# Find and kill the 7-highlander process
pkill -SIGKILL -f "7-highlander"'

create_and_commit_script "8-beheaded_process" "$task8_content"

# Task 9: Process and PID file
echo "Processing Task 9: Process and PID file"

task9_content='#!/usr/bin/env bash
# Script that creates PID file and handles various signals

# Create PID file
echo $$ > /var/run/myscript.pid

# Signal handlers
handle_sigterm() {
    echo "I hate the kill command"
    rm -f /var/run/myscript.pid
    exit 0
}

handle_sigint() {
    echo "Y U no love me?!"
}

handle_sigquit() {
    rm -f /var/run/myscript.pid
    exit 0
}

# Set up signal handlers
trap handle_sigterm SIGTERM
trap handle_sigint SIGINT
trap handle_sigquit SIGQUIT

# Infinite loop
while true; do
    echo "To infinity and beyond"
    sleep 2
done'

create_and_commit_script "10-process_and_pid_file" "$task9_content"

# Task 10: Manage my process - First create the manage_my_process script
echo "Processing Task 10: Manage my process"

manage_my_process_content='#!/usr/bin/env bash
# Script that indefinitely writes "I am alive!" to /tmp/my_process

while true; do
    echo "I am alive!" >> /tmp/my_process
    sleep 2
done'

create_and_commit_script "manage_my_process" "$manage_my_process_content"

# Task 10: Create the init script 11-manage_my_process
task10_content='#!/usr/bin/env bash
# Init script to manage the manage_my_process daemon

case "$1" in
    start)
        ./manage_my_process &
        echo $! > /var/run/my_process.pid
        echo "manage_my_process started"
        ;;
    stop)
        if [ -f /var/run/my_process.pid ]; then
            kill $(cat /var/run/my_process.pid)
            rm -f /var/run/my_process.pid
        fi
        echo "manage_my_process stopped"
        ;;
    restart)
        if [ -f /var/run/my_process.pid ]; then
            kill $(cat /var/run/my_process.pid)
            rm -f /var/run/my_process.pid
        fi
        ./manage_my_process &
        echo $! > /var/run/my_process.pid
        echo "manage_my_process restarted"
        ;;
    *)
        echo "Usage: manage_my_process {start|stop|restart}"
        exit 1
        ;;
esac'

create_and_commit_script "11-manage_my_process" "$task10_content"

echo "=========================================="
echo "✅ ALL TASKS COMPLETED SUCCESSFULLY!"
echo ""
echo "Created and committed the following files in current directory:"
echo "  - 6-stop_me_if_you_can"
echo "  - 7-highlander" 
echo "  - 67-stop_me_if_you_can"
echo "  - 8-beheaded_process"
echo "  - 10-process_and_pid_file"
echo "  - manage_my_process"
echo "  - 11-manage_my_process"
echo ""
echo "All files have been made executable and committed to git."
echo "Master script execution completed! 🎉"
