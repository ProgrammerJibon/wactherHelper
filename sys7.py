import time
from datetime import datetime
import os

folder = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(folder, "timestamp.txt")

with open(file_path, "w") as f:
    f.write(f"Timestamp (seconds): {int(time.time())}\n")
    f.write(f"Current date and time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")


print("Working!!!")