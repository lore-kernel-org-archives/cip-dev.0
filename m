From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 9 Dec 2016 16:01:34 +0100
Subject: [cip-dev] Update week 49
Message-ID: <584AC74E.8080109@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

this is an overview of what is happening at CIP. Feel free to answer 
this mail with your bits.

++ Meetings

* Members meeting on Mon Nov 28th
** The next f2f meeting will take place at ELC in Portland in February
** Testing effort status

++ Kernel Maintenance

* First backports to provide hardware support for Beaglebone Black sent 
to the list for comments and evaluation.

* CIP repository already mirrored in Gitlab.com: 
https://gitlab.com/cip-project/linux-cip/commits/linux-4.4.y-cip Thanks 
Yoshi!

++ Testing

* Progress in the VM with kernelci
** Have browser on host able to view kernelci pages
** Some work (not yet complete) on getting  this setup to happen on 
provisioning of the vm).
** Investigating issues with retrieving the build artifacts.
** Installing of lava2 on the vm

* Added a project in Gitlab.com to mirror the kernelci front end repository.

* Introduction to CIP testing effort published on the wiki: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting

++ Other topics

* Robert Marshall, that is currently working on the kernelci VM will be 
at FOSDEM, like myself.

++ Next Tasks

* In the coming days CIP kernel will update from 4.4.30 to 4.4.37 Once 
we have testing in place it will make sense to test every release and 
update as soon as is everything ok from our side.

* Keep working on the kernelci VM

* Patches review/merge

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
