From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 19 Jul 2017 19:49:57 +0200
Subject: [cip-dev] Procedure to use B@D in Windows 10
In-Reply-To: <87o9sg1vqu.fsf@ctlt579.codethink.co.uk>
References: <87o9sg1vqu.fsf@ctlt579.codethink.co.uk>
Message-ID: <CB0A9D4E-597D-4C15-9257-62E079196E6A@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Robert,

On 19 July 2017 14:01:13 CEST, Robert Marshall <robert.marshall@codethink.co.uk> wrote:
>The 0.9.1 release box of B at D has been successfully imported into
>Windows
>10 and both a QEMU and BBB health check have been run on that virtual
>machine.
>This setup also works when provisioning a box from a clone of the git
>repository.
>
>The steps to get B at D running on Windows 10 are as follows:
>
>- Install the guest additions `vagrant plugin install vagrant-vbguest`
>- Install rsync/ssh/git in cygwin.
>- core.autocrlf=input is needed in the git settings for the scripts to
>    run under the Debian of the virtual machine.
>- Once the vm is up then in virtualbox add a USB filter for the FTDI
>device.
>- For kernelci access you need to use either Firefox or Chrome - the
>Microsoft
>    browsers will not work.
>- You may need the vagrant scp command (if you wish to copy other files
>   onto the VM) if so -
>    vagrant plugin install vagrant-scp
>- setup mybbb.dat to use the IP address of the VM rather than that of
>    the host.

Congratulations for this accomplishment.

>
>The wiki has been updated to document these steps.

So the former 5 steps documentation now includes the specific steps to take if you are a Windows 10 user. There is no separate documentation since most of the instructions to execute are the same in both cases (Windows and Linux).   

>
>Robert
>_______________________________________________
>cip-dev mailing list
>cip-dev at lists.cip-project.org
>https://lists.cip-project.org/mailman/listinfo/cip-dev

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
