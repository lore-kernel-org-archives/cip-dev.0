From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Wed, 30 Jan 2019 16:04:14 +0100
Subject: [cip-dev] Next Debian kernel: when will it be announced?
In-Reply-To: <2887169.qepfFsszbe@linux-if6s>
References: <2887169.qepfFsszbe@linux-if6s>
Message-ID: <CAEss1E+6KsepvfjoXg8fZsuUs6doiA3UGUWnhJLhpawRDk5f_Q@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I finally got to the point that I can upgrade my custom VBox VM with
Lava sans Vagrant from preseeded Debian 9 to Debian 10.

Here is what I got (empirically):

root at stretch1-hostname:~# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux buster/sid"
NAME="Debian GNU/Linux"
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root at stretch1-hostname:~# uname -a
Linux stretch1-hostname 4.19.0-1-amd64 #1 SMP Debian 4.19.12-1
(2018-12-22) x86_64 GNU/Linux
root at stretch1-hostname:~#

Cheers,
Zoran
_______


On Thu, Sep 13, 2018 at 6:21 PM Agust?n Benito Bethencourt
<agustin.benito@codethink.co.uk> wrote:
>
> Hi Ben,
>
> do you know when approximately will the Debian project announce the version of the new kernel?
>
> Best Regards
>
> --
> Agust?n Benito Bethencourt
> Principal Consultant
> Codethink Ltd
> We respect your privacy.   See https://www.codethink.co.uk/privacy.html
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
