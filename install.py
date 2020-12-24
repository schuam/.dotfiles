# -----------------------------------------------------------------------------
# includes
# -----------------------------------------------------------------------------

from datetime import datetime
from subprocess import run
import csv
import os


# -----------------------------------------------------------------------------
# constants
# -----------------------------------------------------------------------------

CONFIG_FILE = "install_config.csv"
HOME = os.path.expanduser("~")
BACKUP_DIR = \
    HOME + "/dotfile_backup_{}/".format(datetime.now().strftime('%Y-%m-%d'))
LOG_FILE_NAME = "log.txt"
LOG_FILE_PATH = os.path.join(BACKUP_DIR, LOG_FILE_NAME)


# -----------------------------------------------------------------------------
# function definitions
# -----------------------------------------------------------------------------

def make_backup_dir():
    if not os.path.isdir(BACKUP_DIR):
        os.makedirs(BACKUP_DIR)


def make_log_file():
    with open(LOG_FILE_PATH, "a") as log:
        log.write(
            "dotfile installation at {}\n".format(datetime.now().isoformat())
        )
        log.write("comments run:\n")


def run_command(cmd):
    with open(LOG_FILE_PATH, "a") as log:
        log.write("[cmd] {}\n".format(cmd))
    run(cmd)


def backup(path):
    if os.path.exists(path):
        run_command("mv {} {}".format(path, BACKUP_DIR))


def install_configuration(src, dst, method):
    cmd = "{} {} {}"
    src = os.path.abspath(src)
    dst = os.path.abspath(os.path.expanduser(dst))
    if method == "link":
        target = os.path.split(src)[-1]
        dst = os.path.join(dst, os.path.split(src)[-1])
        cmd = cmd.format("ln -snv", src, dst)
    elif method == "copy":
        cmd = cmd.format("cp", src, dst)
    else:
        pass

    backup(dst)
    run_command(cmd)


def install_all():
    with open(CONFIG_FILE) as configuration:
        reader = csv.DictReader(configuration)
        for row in reader:
            if row["use"] == "yes":
                install_configuration(row["src"], row["dst"], row["method"])


def main():
    make_backup_dir()
    make_log_file()
    install_all()


# -----------------------------------------------------------------------------
# take action
# -----------------------------------------------------------------------------

if __name__ == "__main__":
    main()

