# Born2beRoot

# What is Born2beRoot?

*My second project at 42.*

This project aims to introduce the students to virtualization by creating their first machine in VirtualBox under specific instructions.

**Virtualization**, as explained in [ibm.com](https://www.ibm.com/cloud/learn/virtualization-a-complete-guide), "*uses software to create an abstraction layer over computer hardware that allows the hardware elements of a single computer—processors, memory, storage and more—to be divided into multiple virtual computers, commonly called virtual machines (VMs). Each VM runs its own operating system (OS) and behaves like an independent computer, even though it is running on just a portion of the actual underlying computer hardware.*".

But... what is a **VM**? A **VM**, as define in [vmware.com](https://www.vmware.com/topics/glossary/content/virtual-machine), "*is a compute resource that uses software instead of a physical computer to run programs and deploy apps. One or more virtual “guest” machines run on a physical “host” machine. Each virtual machine runs its own operating system and functions separately from the other VMs, even when they are all running on the same host. This means that, for example, a virtual macOS virtual machine can run on a physical PC.*".

VMs may be deployed to accommodate different levels of processing power needs, to run software that requires a different operating system, or to test applications in a safe, sandboxed environment.

At the end of this project, I was able to set up my own operating system while implementing strict rules.

# Steps

*These were the specific rules and steps I followed to set up the server.*

## Choosing the OS: Debian vs CentOS

[Debian](https://www.debian.org) is highly recommended for users that are new to system administration since is easier to install and configure than **[CentOS](https://www.centos.org)**.

Here are some key differences between both OS:

- Supported architecture: Both have some commonly supported architectures, such as AArch64/ARM64, armhf/armhfp, i386 or ppc64el/ppc64le, but there are other architectures that are only supported in one of them.
- Package management:
    - CentOS uses the RPM package format and YUM/DNF as the package manager.
    - Debian uses the DEB package format and dpkg/APT as the package manager.
- Filesystems: CentOS supports XFS, while Debian EXT4. Both also support ext2/3, NFSv3/4, btrfs, SMB, GFS2...
- Kernel: The latest Linux kernel is supported in Debian, while CentOS supports older versions.
- Upgrading: Debian supports major version updates, while CentOS only support minor upgrades (CentOS major releases can have a time span of 10 years).
- Support: Debian is primarily community-supported, with a larger community than CentOS. Some downstream distributions based on Debian have commercial support options, such as Ubuntu.

Therefore, I decided to go with **Debian**, since it is recommended for new users and small or personal servers. I used the most recent Debian version at that time: Debian 11, codenamed bullseye, netinst, for 64-bit PC.

# Set up the VM in VirtualBox

To set up the VM I used [Virtual Box](https://www.virtualbox.org), since it was mandatory (although we could use [UTM](https://getutm.app) in case we could not use Virtual Box). These are the settings I used for my machine:

- Name: born2beroot.
- Type of OS: Linux.
- Version: Debian (64-bit).
- Memory Size: 1024 MB.
- Hard disk: Create a virtual hard disk file.
- File size:  8.00 GB.
- Hard disk file type: VDI (VirtualBox Disk Image).
- Storage on physical hard disk: Dynamically allocated.

It is possible to load the Virtual Optical Disk File of the OS (**.iso**) once the created VM is started, but I decided to do it from the VM Settings in Virtual Box, by going to Storage → Controller: IDE → 💿 (under Attributes).

I also changed the scale factor to 300% under Display settings, since the computer I was using started the VM in a very small window.

# Installation of the OS

## Basic installation set up

Once the VM is started with the **.iso** file loaded, in the first menu that appears is the Debian GNU/Linux installer menu, in which I selected the **Install** option (**not** the Graphical install).

A graphical user interface (GUI), explained at [computerhope.com](https://www.computerhope.com/jargon/g/gui.htm), "*is a system of interactive visual components for computer software. A GUI displays objects that convey information, and represent actions that can be taken by the user. The objects change color, size, or visibility when the user interacts with them.*".

It was also mandatory that we did not install a GUI, but it is understandable since this project was about setting up a server with the minimum services installed, meaning that a GUI was o no use here.

I chose **English** as the *language* of my installation, **Spain** as my *location,* the **United States** as the *country to base the default locale settings on*, **Spanish** as my *keyboard layout*.

My hostname was my 42 intranet username with a 42 added at the end (something like this: *intrausername42*). I left the *domain name* empty and set a secure *Root password*. Then I used my *full name* for the new user to be created, my 42 intranet username for its *username,* and set another secure *password* for it. Lastly, I set **Madrid** as my *time zone*.

As explain in [apple.com](https://support.apple.com/guide/directory-utility/about-the-root-user-dirub32398f1/mac), "*the user named root, or superuser, is a special user account in UNIX-like operating systems that has unrestricted read and write privileges to all areas of the file system*".

## Partitioning and Base System

First of all, a partition is defined in [computerhope.com](https://www.computerhope.com/jargon/p/partition.htm) as: "*A disk partition or partition is a section of the hard drive that is separated from other segments. Partitions enable users to divide a physical disk into logical sections. For example, allowing multiple operating systems to run on the same device*.".

There are two main types of partitions: *logical* or *primary*, but... what is the difference between both? [easeus.com](https://www.easeus.com/partition-master/logical-vs-primary.html) has a nice comparison:

"*Logical partition and primary partition are two common partition types.*

- The *primary partition is the hard disk partition where both OS and other data can be stored, and it is the only partition that can be set active for BIOS to locate. In other words, you can only boot from a primary partition.* (The number of primary partitions that can be created is **limited**).
- *The logical partition is also called LPAR, it is a logical segmentation of a mainframe's memory and other resources that allows it to run its own copy of the operating system and associated applications. (*The number of logical partitions that can be created is **unlimited**).

*There is no difference between the two kinds of partitions in the ability to store data.*"

I decided to do the project **without the bonus** part, so I went with *guided* partitioning.

After selecting *Guided - use entire disk and set up encrypted LVM*, I chose **SCSI3 (0, 0, 0) (sda) - 8.6 GB ATA VBOX HARDDISK**, to start partitioning my entire disk.

![](https://github.com/Javiff8/Born2beRoot/blob/master/Screenshots/Untitled.png)

*LVM or Logical Volume Manager (LVM), described in [wiki.ubuntu.com](https://wiki.ubuntu.com/Lvm), "It is a system of managing logical volumes, or filesystems, that is much more advanced and flexible than the traditional method of partitioning a disk into one or more segments and formatting that partition with a filesystem.".*

On the other hand,  a filesystem, explained in [linfo.org](http://www.linfo.org/mount_point.html), "*is a hierarchy of directories (also referred to as a [directory tree](http://www.linfo.org/directory_tree.html)) that is used to organize files on a computer system. On [Linux](http://www.linfo.org/linuxdef.html) and other [Unix-like](http://www.linfo.org/unix-like.html) [operating systems](http://www.linfo.org/operating_systems_list.html), at the very top of this hierarchy is the [root directory](http://www.linfo.org/root_directory.html), which contains all other directories on the system, inclusive of their subdirectories, etc. A variant of this definition is the part of the entire hierarchy of directories (i.e., of the directory tree) that is located on a single [partition](http://www.linfo.org/partition.html) or disk. A partition is a logically independent section of a hard disk drive (HDD).*"*.*

SCSI, defined in [wikipedia.org](https://en.wikipedia.org/wiki/SCSI), "*Small Computer System Interface (SCSI) is a set of standards for physically connecting and transferring data between computers and peripheral devices. The SCSI standards define commands, protocols, electrical, optical and logical interfaces.*".

I chose to have a *separate /home partition*, and let the installer start the encryption. *Encrypting* is a quite useful tool to protect personal or sensitive data from loss or theft, but can also make data recovery more difficult or even impossible. Moreover it also has an impact on system performance.

At the end of the process the following partitions were created:

- / - Which is the root directory where all the data from our operative system will be stored.
- /home - Where user data will be saved.
- /boot - To start (or boot) the operative system. *(Explained in the following paragraphs).*

- swap - Here is the explanation [makeuseof.com](https://www.makeuseof.com/tag/swap-partition/) gives about swap partitions: "*The swap partition serves as overflow space for your RAM. If your RAM fills up completely, any additional applications will run off the swap partition rather than RAM. The swap partition serves as overflow space for your RAM. If your RAM fills up completely, any additional applications will run off the swap partition rather than RAM.*".

![Untitled](Born2beRoot%20fd2ec214b16d43aca7944dff73f3724a/Untitled%201.png)

The boot process is explained in [oreilly.com](https://www.oreilly.com/library/view/essential-system-administration/0596003439/ch04s01.html) as it follows: "*Bootstrapping is the full name for the process of bringing a computer system to life and making it ready for use. The name comes from the fact that a computer needs its operating system to be able to do anything, but it must also get the operating system started all on its own, without having any of the services normally provided by the operating system to do so. Hence, it must “pull itself up by its own bootstraps.*

*The normal Unix boot process has these main phases:*

- *Basic hardware detection (memory, disk, keyboard, mouse, and the like).*
- *Executing the firmware system initialization program (happens automatically).*
- *Locating and running the initial boot program (by the firmware boot program), usually from a predetermined location on disk. This program may perform additional hardware checks prior to loading the kernel.*
- *Locating and starting the Unix kernel (by the first-stage boot program). The kernel image file to execute may be determined automatically or via input to the boot program.*
- *The kernel initializes itself and then performs final, high-level hardware checks, loading device drivers and/or kernel modules as required.*
- *The kernel starts the `init` process, which in turn starts system processes (daemons) and initializes all active subsystems. When everything is ready, the system begins accepting user logins.*"

After that, I select *Finish partitioning and save changes to disk* and let Debian install the base system.

## Package Manager and other software

As define in [wikipedia.org](https://en.wikipedia.org/wiki/Package_manager), "*A package manager or package management system is a collection of software tools that automates the process of installing, upgrading, configuring, and removing computer programs for a computer's operating system in a consistent manner.*"

After the last step, since I did not use a CD for the installation, I selected **no** when a prompt asking for it appeared.

Now, for the configuration of the **package manager**, I chose **Spain** and *deb.debian.org* as the Debian archive mirror. As explained in the [debian.org](https://www.debian.org/mirror/list.en.html) webpage, "*Debian is distributed (mirrored) on hundreds of servers on the Internet. Using a nearby server will probably speed up your download, and also reduce the load on our central servers and on the Internet as a whole.*".

What does mirroring mean? Server mirroring, explained in [techopedia.com](https://www.techopedia.com/definition/1156/server-mirroring), "*is continuously created on run time. Server mirroring is a technique used for business continuity, disaster recovery, and backup. Duplicating the entire contents of a server on another remote or in-house server allows data to be restored if the primary server fails.*".

Also, I did not write anything into the *proxy* field, since I did not need one.

However, while configuring the package manager, I got this error message:

So I left its configuration for later and chose **no** when asked to participate in the package usage survey. Then for the software selection, I unselected SSH server and **standard system utilities**. When asked about installing GRUB (a boot loader to load the OS when the VM starts) I selected **yes** and selected **/dev/sda**.

![Untitled](Born2beRoot%20fd2ec214b16d43aca7944dff73f3724a/Untitled%202.png)

# Configure the machine

### Installing `sudo`

Now, when the OS loaded, the first thing to be done was to write the encryption password and log into the user created during the installation.

Now to start with the configuration and installing software it is necessary to write the `su` command and enter the host password. This is the definition of `su` in [wikipedia.org](https://en.wikipedia.org/wiki/Su_(Unix)): "*The [Unix](https://en.wikipedia.org/wiki/Unix) command **su**, which stands for 'substitute user', is used by a computer user to execute commands with the privileges of another user account. When executed it invokes a [shell](https://en.wikipedia.org/wiki/Shell_(Unix)) without changing the current working directory or the user environment. When the command is used without specifying the new user id as a [command-line argument](https://en.wikipedia.org/wiki/Command_line#Arguments), it defaults to using the [superuser](https://en.wikipedia.org/wiki/Superuser) account (user id 0) of the system.*"

This allows the installation of packages, software, etc. with superuser permissions, so I started with sudo with `apt install sudo`.

`apt` or Advanced Package Manager, is explained in codebust.io: "*Ubuntu is dependent on [Debian Linux](https://www.debian.org/) and Debian Linux uses a [dpkg](https://wiki.debian.org/DebianPackageManagement) packaging system. A packaging system simply provides programs and applications for installation.*

*APT (Advanced Package Tool) is a command-line tool that is used for easy interaction with the dpkg packaging system and it is the most efficient and preferred way of managing software from the command line for Debian and Debian-based Linux distributions like Ubuntu. It manages dependencies effectively, maintains large configuration files and properly handles upgrades and downgrades to ensure system stability.*".

It is also important to know the difference between apt and Aptitude. Aptitude is a high-level package manager while APT is a lower-level package manager which can be used by other higher-level package managers.

Moreover, [tecmint.com](https://www.tecmint.com/difference-between-apt-and-aptitude/) has a nice definition of what is Aptitude: "*Aptitude is a front-end to advanced packaging tool which adds a user interface to the functionality, thus allowing a user to interactively search for a package and install or remove it. Initially created for Debian, Aptitude extends its functionality to RPM based distributions as well*.".

Lastly, `sudo` allows running a single command with root privileges, while `su` allows selecting which user will run the program, which normally is the root user when it is executed with no additional options and does not stop until `exit` is typed in the root shell.

While on root after using `su` I executed `adduser <myuser> sudo` to add **<myuser>** to the **sudo** group so that user can use the `sudo` command.

After, I executed `sudo -v`, which made sudo update the user's cached credentials, authenticating the user's password if necessary.

After I used `sudo addgroup <myusername42>`, to create the group **<myuser42>**, and `sudo adduser <myusername> <myusername42>` to add **<myuser>** to the group **<myuser42>**.

To finish, I `sudo apt update` to update all the packages of the system.

## Installing `ssh`

"*SSH, also known as Secure Shell or Secure Socket Shell, is a network protocol that gives users, particularly system administrators, a secure way to access a computer over an unsecured network. In addition to providing secure network services, SSH refers to the suite of utilities that implement the SSH protocol. Secure Shell provides strong password authentication and public key authentication, as well as encrypted data communications between two computers connecting over an open network, such as the internet. In addition to providing strong encryption, SSH is widely used by network administrators for managing systems and applications remotely, enabling them to log in to another computer over a network, execute commands and move files from one computer to another.*" - [searchsecurity.techtarget.com](https://searchsecurity.techtarget.com/definition/Secure-Shell).

In this part, I installed the *OpenSSH Service* which, as described in the [openssh.com](http://openssh.com), "I*s the premier connectivity tool for remote login with the SSH protocol. It encrypts all traffic to eliminate eavesdropping, connection hijacking, and other attacks. In addition, OpenSSH provides a large suite of secure tunneling capabilities, several authentication methods, and sophisticated configuration options.*".

The OpenSSH Service allows to use the SSH network protocol, so I installed it using `sudo apt install openssh-server`. Then I used nano to edit the **sshd_config** file to change and uncoment the **Port** from *22* to **4242** and **PermitRootLogin** from *prohibit-password* to **no** so that it will be impossible to connect using **ssh** as root (this was mandatory) via `sudo nano /etc/ssh/sshd_config`. I also changed the **Port** from *22* to **4242** in the **ssh_config** file following the same procedure but this time using `sudo nano /etc/ssh/ssh_config`.

The difference between **ssh** and **sshd** is well explained in [secur.cc](https://www.secur.cc/what-is-the-difference-between-ssh-and-sshd/): "*sshd is a server (like a web server serving https) and SSH is a client (think of a web browser). The client/user authenticates itself against the server using the users credentials. and the server provides its own public key which can be fingerprinted, checked and remembered to by the client in order to prevent MITM attacks.*".

![Untitled](Born2beRoot%20fd2ec214b16d43aca7944dff73f3724a/Untitled%203.png)

![Untitled](Born2beRoot%20fd2ec214b16d43aca7944dff73f3724a/Untitled%204.png)

After that, I checked that **ssh** was running using: `sudo service ssh status`.

![Untitled](Born2beRoot%20fd2ec214b16d43aca7944dff73f3724a/Untitled%205.png)

## Installing `UFW`

"*Uncomplicated Firewall (UFW) is a program for managing a [netfilter firewall](https://en.wikipedia.org/wiki/Netfilter) designed to be easy to use. It uses a [command-line interface](https://en.wikipedia.org/wiki/Command-line_interface) consisting of a small number of simple commands, and uses [iptables](https://en.wikipedia.org/wiki/Iptables) for configuration. UFW is available by default in all Ubuntu installations after 8.04 LTS.*". - [en.wikipedia.org](https://en.wikipedia.org/wiki/Uncomplicated_Firewall).

Installing UFW and setting it up was as simple as executing `sudo apt instal ufw`, then activating and enabling it to launch on system start up via `sudo ufw enable` and opening the port 4242 (this was mandatory) using `sudo ufw allow 4242`. To check if it was working correctly, I used `sudo ufw status` and checked that the **4242** and **4242(v6)** *ports* were **allowed** **from anywhere**.

If I used  `sudo ufw status verbose`, I could see that Default: outgoing was allowed, so I also used `sudo ufw default deny outgoing` to deny it because it was also mandatory.

## Configuring `sudo`

To configure `sudo`, I started by creating a log directory to store the log file that would archive each action performed using sudo. by doing `sudo mkdir /var/log/sudo`. After this, I used `sudo visudo` to edit the **sudoers.tmp** file and added:

- **Defaults passwd_tries=3** - To set the number of password attempts when using `sudo` to 3.
- **Defaults badpass_message="Wrong password"** - The error message due to a wrong password.
- **Defaults logfile="/var/log/sudo/sudo.log"** - To create and set the log file.
- **Defaults log_input,log_output** - To create the logs of the inputs and outputs of every use of `sudo`.
- **Defaults iolog_dir="/var/log/sudo"** - The directory where those logs will be stored (created previously).
- **Defaults requiretty** - To enable TTY mode. Defined in [shell-tips.com](https://www.shell-tips.com/linux/sudo-sorry-you-must-have-a-tty-to-run-sudo/): "*TTY stand for teletypewriter which comes through a long history before the computer era. Nowadays, the tty command is used to provide the file name of the terminal connected to the standard input, example: /dev/ttys001.*". If some non-root code is exploited (a PHP script, for example), the `requiretty` option means that the exploit code won't be able to directly upgrade its privileges by running `sudo`.
- **Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"** - To restrict the PATHs that can be used by `sudo` specifically to those specified.

## Setting up a strong password policy

To set up a strong password policy, I opened with `nano` the `/etc/login.defs` file and edited a couple of things (*these settings were requirements for the project*):

- **PASS_MAX_DAYS 30** - To make passwords expire after 30 days.
- **PASS_MIN_DAYS 2** - To set the minimum number of days allowed before the modification of a password to 2.
- **PASS_WARN_AGE 7** - To make the user receive a warning message 7 days before their password expires.

After that, I installed with `sudo apt install libpam-pwquality` the libpam-pwquality package, which purpose is to provide common functions for password quality checking and also scoring them based on their apparent randomness.

Then, I edited the *common-password* file under `/etc/pam.d/common-password` with `sudo nano` and added the following parameters to the first line under *#here are the per-package modules (the "Primary" block)* line:

- **minlen=10** - Sets the minimum acceptable size for the new password to 10.
- **ucredit=-1** - The password must contain an uppercase letter.
- **dcredit=-1** - The password must contain a digit.
- **maxrepeat=3** - The password must contain more than 3 consecutive identical characters.
- **reject_usernam**e - The password must not include the name of the user.
- **difok=7** - The password must have at least 7 characters that are not part of the former password (does not apply to the root password).
- **enforce_for_root** - The root password has to comply with this policy.

After this settings, the resulting line was this: `password requisite pam_pwqiality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root`

Now, to compile with the password policy, I changed the passwords of the **root user** and the **user** created during installation using `passwd` and `sudo passwd` respectively.

## Network adapter configuration

After all of this, if I could not access my VM from the host computer terminal because the network adapter was not correctly configured. There are two ways to get around this issue.

1. Going in VirtualBox to:

    VM settings → Network  → Advanced → Port Forwarding → New rule (top left corner):

    - **Protocol**: TCP
    - **Host** **IP**: 127.0.0.1
    - **Host** **Port**: 4242
    - **Guest** **IP**:  10.0.2.15
    - **Guest** **Port**: 4242

After this, using `ssh <myvmuser>@localhost -p 4242` (after booting up the VM and logging in) asked for the user password and allowed the host terminal to access the VM. This way, it was possible to connect to the VM without writing the VM IP in the command line.

It is also posible to leave empty the Gest IP and Host IP fields and connect using `ssh <myvmuser>@127.0.0.1 -p 4242`

1. Going to VirtualBox:

    VM settings → Network  → Adapter 1 → Attached to → Bridged Adapter

    After this, booting up the VM, logging in, and using `ip a`, showed the IP of the VM along with other stuff. Writing this IP in the same command line as before in the host terminal allows the connection after typing the VM user's password: `ssh <myvmuser>@<VMIP> -p 4242`.


![Screen Shot 2021-09-24 at 6.53.01 PM.png](Born2beRoot%20fd2ec214b16d43aca7944dff73f3724a/Screen_Shot_2021-09-24_at_6.53.01_PM.png)

# Make a crontab file

A crontab file contains instructions for the cron(8) daemon in the following simplified manner: “run this command at this time on this date".

It was mandatory to create a **[monitoring.sh](https://github.com/Javiff8/Born2beRoot/blob/master/monitoring.sh)** file under `/usr/local/bin/` that must be launched on system start and every 10 minutes.

For this I used `sudo crontab -e` and added `*/10 * * * * /usr/local/bin/monitoring.sh`.

I also added this lines to the `sudo visudo` file:

`<myuser> ALL=(ALL) NOPASSWD: /usr/local/bin/monitoring.sh` - To make the script without the sudo password.

`<myuser> ALL=(ALL) ALL` - To make my user have sudo permissions.

# [Signature.txt](https://github.com/Javiff8/Born2beRoot/blob/master/signature.txt)

Lastly, we were requested to create a .txt file that contained the signature of our VM. Since I was using MacOS on an Intel Mac, I went to my VM folder and did `shasum <myVMname>.vdi` to create the signature and pasted it onto the [signature.txt](https://github.com/Javiff8/Born2beRoot/blob/master/signature.txt) file.

# Other questions

*Here are some useful definitions that I needed to know for my evaluation*

## AppArmor vs SELinux

 Explained in [security.stackexchange.com](https://security.stackexchange.com/questions/29378/comparison-between-apparmor-and-selinux):

"*These security systems provide tools to isolate applications from each other... and in turn isolate an attacker from the rest of the system when an application is compromised.*

*SELinux rule sets are incredibly complex but with this complexity you have more control over how processes are isolated. Generating these policies [can be automated](http://magazine.redhat.com/2007/08/21/a-step-by-step-guide-to-building-a-new-selinux-policy-module/). A strike against this security system is that its very difficult to independently verify.*

*AppArmor (and SMACK) is very straight forward. The profiles can be hand written by humans, or generated using `aa-logprof`. AppArmor uses path based control, making the system more transparent so it can be independently verified.*"

AppArmor also provides MAC (Mandatory Access Control) security, allowing the system administrator to restrict the actions some processes can perform.

# Useful commands

## Simple setup

`chage -l <username>` - Checks if passwords rules are working on the user.

`sudo ufw status` - Checks the ufw status.

`sudo service ssh status` - Checks the status of the ssh.

`uname -a` - Checks the operating system.

`head -n 2 /etc/os-release` - Also checks the operating system.

## User

`getent group` - Checks the groups created.

`getent group <groupname>` - Checks the users under a group.

`sudo adduser <username>` - Creates a new user.

`sudo /etc/pam.d/common-password` - To set the length of the password, the characters...

`sudo nano /etc/login.defs` - To set password expiration date, etc.

`sudo addgroup <groupname>` - Creates a new group.

`sudo adduser <username> <groupname>` - Adds a user to a group.

## Hostname and partitions

`hostname` - Check current hostname.

`sudo hostnamectl set-hostname <newhostname>` - Changes the hostname.

`sudo nano /etc/hosts` - And then change the old hostname for the new one.

`lsblk` -  See the partitions.

## Sudo

`command -v sudo` - To check if sudo is installed.

`sudo adduser <username> sudo` - Adds the user to the sudo group.

`sudo visudo` - Access sudoers file to edit the configuration of sudo.

## UFW

`command -v ufw` - To check if ufw is installed.

`sudo ufw status` - Checks the ufw status.

`sudo ufw allow <port_number>` - Allows the port indicated.

`sudo ufw status numbered` - Checks the ufw status with numbers on the left of each rule.

`sudo ufw delete <number>` - Deletes the rule that corresponds to that number.

## SSH

`command -v ssh` - To check if ssh is installed.

`sudo service ssh status` - Checks the status of the ssh.

`sudo nano /etc/ssh/ssh_config` - To check the port used by ssh.

`ip a` - To check the IP to use for connect from the host terminal.

`ssh <vmusername>@<vmip> -p 4242` - (In the host terminal) to connect to the VM using ssh.

## Script monitoring

`sudo crontab -e` - To edit the crontab file.

`sudo nano /usr/local/bin/monitoring.sh` - To edit the monitoring.sh file

## Other Commands

`cut -d: -f1 /etc/passwd` - Checks all the users in the machine.

`groups` - Checks which groups my user belongs to.

`/usr/sbin/aa-status` - Checks the status of AppArmor.

`ss -tulp` - Shows the net status, ports...
