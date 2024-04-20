# syncthing_checks
Check for failures to sync for the popular syncthing sytem (Windows PowerShell)

### Step 1: Save the PowerShell Script

1.  **Create the Script File:**
    
    *   Open Notepad or any text editor.
        
    *   Copy and paste the modified PowerShell script provided earlier.
        
    *   Save the file with a **.ps1** extension, for example, **CheckSyncConflictFiles.ps1**.
        
2.  **Save Location:**
    
    *   Save the script in a location that won't change, such as **C:\\Scripts\\CheckSyncConflictFiles.ps1**.
        

### Step 2: Configure Task Scheduler

1.  **Open Task Scheduler:**
    
    *   Press **Windows Key + R**, type **taskschd.msc**, and hit Enter to open Task Scheduler.
        
2.  **Create a New Task:**
    
    *   In the right pane, click on **Create Task**.
        
3.  **General Tab:**
    
    *   **Name:** Enter a name for the task, e.g., "Check Sync Conflict Files".
        
    *   **Security options:** Choose **Run whether user is logged on or not** and tick **Do not store password**. This ensures the task can run in most conditions.
        
    *   Check **Run with highest privileges** if your script requires administrative rights.
        
4.  **Triggers Tab:**
    
    *   Click **New...** to create a new trigger.
        
    *   **Begin the task:** Choose **On an event**.
        
    *   **Settings:** Select **Custom** and then click on **New Event Filter...**.
        
    *   **Filter Tab:**
        
        *   **Logged:** At least the last hour (or another appropriate setting).
            
        *   **Event sources:** Kernel-Power.
            
        *   **Event IDs:** Enter **507** (Event ID for when the system is resuming from sleep).
            
    *   Confirm with **OK**, then back in the trigger window, under **Advanced settings**, check **Delay task for:** and set it to **3 minutes**.
        
5.  **Actions Tab:**
    
    *   Click **New...** to create a new action.
        
    *   **Action:** Choose **Start a program**.
        
    *   **Program/script:** Type **powershell.exe**.
        
    *   **Add arguments (optional):** Enter **\-ExecutionPolicy Bypass -File "C:\\Scripts\\CheckSyncConflictFiles.ps1"**. Adjust the path to where you saved your script.
        
    *   **Start in (optional):** Enter the path to the folder containing the script, e.g., **C:\\Scripts**.
        
6.  **Conditions Tab:**
    
    *   Under **Power**, check **Start the task only if the computer is on AC power** if you want to avoid running on battery.
        
    *   Uncheck **Stop if the computer switches to battery power** if it was checked.
        
7.  **Settings Tab:**
    
    *   Ensure **Allow task to be run on demand** is checked.
        
    *   **If the task fails, restart every:** can be set based on your preference if you expect issues or if the task is critical.
        
    *   Make sure the **Stop the task if it runs longer than:** and **If the running task does not end when requested, force it to stop** are configured as needed.
        
8.  **Save the Task:**
    
    *   Click **OK** to save the task. You might be prompted to enter your user credentials to allow the task to run with administrative privileges.
        

### Step 3: Test the Task

*   You can test the task by putting your computer into sleep mode and then resuming. Check if the script runs 3 minutes after the system resumes.
    

This setup ensures that your script checks for **.sync-conflict-** files 3 minutes after your computer wakes up from sleep or hibernation, making it an efficient way to monitor and manage file conflicts that may occur due to sync issues.
