#!/bin/bash

# Ask user to input path to folder and name
echo "Please enter the directory you want to compile: "
read -e -p 'Path: ' path

echo "Please enter application name: "
read -p 'Name: ' name

if [ -d "$path" ]
then
    echo "Directory $path exists."
else
    echo "Error: Directory $path does not exists."
    exit 1
fi

# Check if all files are available
if [ -f "${path}/INFO" ]
then
    echo "File ${path}/INFO exists."
else
    echo "Error: File ${path}/INFO does not exists."
    exit 1
fi

if [ -d "${path}/package" ]
then
    echo "Directory ${path}/package exists."
else
    echo "Error: Directory ${path}/package does not exists."
    exit 1
fi

if [ -d "${path}/conf" ]
then
    echo "Directory ${path}/conf exists."
else
    echo "Error: Directory ${path}/conf does not exists."
    exit 1
fi

if [ -d "${path}/icons" ]
then
    echo "Directory ${path}/icons exists."
else
    echo "Error: Directory ${path}/icons does not exists."
fi

if [ -d "${path}/../output" ]
then
    echo "Directory ${path}/output exists, deleting folder..."
    rm -R "${path}/../output"
    mkdir "${path}/../output"
else
    echo "Directory ${path}/output does not exists, create..."
    mkdir "${path}/../output"
fi

# Compiling Package
mkdir "${path}/../output/tmp"
cp -r "${path}/." "${path}/../output/tmp/"
tmppath="$PWD"
cd  "${path}/../output/tmp/package/"
tar -czf "../package.tgz" *
cd "$tmppath"
rm -R "${path}/../output/tmp/package"
cd  "${path}/../output/tmp/"
tar -cvf "../${name}.spk" *
cd "$tmppath"
rm -R "${path}/../output/tmp"

exit 0
