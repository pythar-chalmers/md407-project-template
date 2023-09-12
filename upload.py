#!/usr/bin/env python

import argparse
import serial
import time

from serial import Serial


def send_command(port: Serial, command: str):
    port.write(command.encode())
    time.sleep(0.1)  


def load_program(port: Serial, payload_path: str):
    print(f"Uploading \"{payload_path}\"...")
    print(" -> load")
    send_command(port, "load\r")
    with open(payload_path, "r") as file:
        code = file.read()
        print(" -> [uploading code]...")
        port.write(code.encode())
        time.sleep(0.01)  
    print(" -> go")
    send_command(port, "go\r")


def main():
    print("\n\n----MD407-Upload----")
    parser = argparse.ArgumentParser(description="Load program over serial connection to the MD407")
    parser.add_argument("port", help="Port path (e.g., /dev/ttyACM0)")
    parser.add_argument("file", help="Path to .s19 file")
    args = parser.parse_args()

    port_name = args.port
    payload_path = args.file

    print("Opening connection to the MD407...")
    port = serial.Serial(port_name, 115200, timeout=1)

    print("Attempting to upload .s19...")
    load_program(port, payload_path)

    # Close the serial connection
    port.close()
    print("Done.")
    print("--------------------\n\n")


if __name__ == "__main__":
    main()
