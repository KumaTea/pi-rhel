# pi-rhel
How To: Install Red Hat Enterprise Linux on Raspberry Pi

![neofetch](img/001-neofetch.jpg)

---

<details>
  <summary>How I come up with this thought...</summary>

Seems like a compensation for [the killing of CentOS](https://the-report.cloud/ibms-red-hat-just-killed-centos-as-we-know-it-with-centos-stream-stability-goes-out-of-the-door),
Red Hat announced a [no-cost RHEL individual subscription](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux).
That is to say, you can run genuine RHEL, legally, for free.

Whoa, sounds like a better choice than CentOS, right?

But I don't have a physical machine to try it out, except for a Raspberry Pi 4B.
Then I wonder, how could I do that?

I started by searching for a tutorial, but Bing gives a rather annoying assertion.

![Bing](img/002-bing.jpg)

Just a second before I was about to give up,
I surprisingly found that [Oracle Linux](https://www.oracle.com/linux),
an RHEL derivatives distributed by Oracle
~~who blocked me 100+ times for registering their cloud service~~,
releases [prebuilt image for Raspberry Pi 4B, 400 and 3B/+](https://www.oracle.com/linux/downloads/linux-arm-downloads.html).

![Oracle Linux for Pi](img/003-oracle.jpg)

That's the only distro that supports Pi as far as I know.

Luckily after a few days of effort,
I managed to find a way to install RHEL use it as a springboard.
The instructions are as follows.

</details>

## Prerequisite

* A Raspberry Pi 4B, 400 or 3B/+
  * Only tested on 4B
* A system drive
  * Note: SSD via USB is highly recommended against SD card
* Red Hat Individual Subscription
* Internet connection

## Registering for Red Hat Individual Subscription

As mentioned above, [register for Red Hat Individual Subscription](https://developers.redhat.com/register).

After the registration process, you should see the following subscriptions
on [your management page](https://access.redhat.com/management/subscriptions):

![Subscriptions](img/004-rh-sub.jpg)

Registration is necessary since we need to update packages from RHEL's repositories.

## Installing Oracle Linux

[Download Oracle Linux](https://www.oracle.com/linux/downloads/linux-arm-downloads.html) first.

Then, find a flashing tool you like.
Generally, [Raspberry Pi Imager](https://www.raspberrypi.com/software/#:~:text=Pi%20OS%20using-,Raspberry%C2%A0Pi%C2%A0Imager,-Raspberry%20Pi%20Imager)
is a good choice, but I personally prefer [Etcher](https://etcher.io).

The downloaded image has been compressed in `xz` format. You don't need to decompress the file, the tool will handle it.

![Flashing](img/005-flash.jpg)

<details>
  <summary>You probably need an SSD...</summary>

### SSD vs SD Card

Oracle Linux comes with `btrfs` for its root filesystem, which is horribly slow for SD card and USB drive.

`btrfs` has ruined a total of 5 SDs and USB drives, just for this tutorial.
So I'd recommend use a SSD if you could.

As for SD cards, `f2fs` should be a much better choice, if possible.

</details>

Plug in your system drive, and boot the pi.
Then go to your router's DHCP clients page, find the IP address of your Pi.

![DHCP](img/006-dhcp.jpg)

`ssh` to your Pi using username `root` and password `oracle`.
You will be asked to change the password immediately.

![SSH](img/007-first-ssh.jpg)

## Preparing the system

## Patching and Running `convert2rhel`

## Registering the System

## Replacing Repositories of Packages

## FAQs
