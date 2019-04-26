From: christian.storm@siemens.com (Christian Storm)
Date: Fri, 26 Apr 2019 10:31:06 +0200
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <OSAPR01MB37639B3931B3AA6A9765099BD03E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <20190426083106.643evxbnzkxyhqsy@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> > > Background: during the last Linaro connect in Bangkok I was told
> > > that Linaro Edge (LEDGE) were working on a secure software update
> > > mechanism based on UEFI capsules that would flash firmware updates
> > > from a UEFI application, instead of using a Linux agent such as
> > > SWUpdate.
> > 
> > How would capsules help with writing to arbitrary storage, updating
> > only files on filesystem, reducing the update size (binary diffs),
> > or talking to the cloud?
> 
> - arbitrary storage: I guess they can only write to what is supported
>   by the machine's UEFI implementation.
> 
> - updating only files on filesystem: I assume this is out of scope in
>   their architecture (Francois: do you want to support file-based
>   updates or only block-based ones?)

> - reducing the update size (binary diffs), or talking to the cloud:
>   they will do that from non-secure Linux. It would be dangerous to use
>   a fragile network stack from an UEFI application or the secure world.
>   In that sense, they also need a Linux agent.

If I understand the idea correctly, there's then a Linux companion agent
that does, e.g., the cloud communication and sets up the update payload
to be consumed and applied by the UEFI firmware update application. The
actual update action will take place on reboot, e.g., flashing the
inactive partition in an A/B setup and thereafter booting into the newly
flashed, then active partition.

If so, this would prolong the time the system is unavailable due to disk
flashing I/O in the UEFI firmware update application compared to flashing
the inactive partition from within Linux and have the bootloader just
switch the to be booted partitions.

Generally, but in particular regarding binary diffs, a binary diff
application mechanism would have to be implemented and maintained in the
UEFI realm as opposed to "just" using the respective shared libraries
(e.g. librsync, casync, ...) in the Linux realm. Granted, one could
come up with a unified format to which the output of, e.g, librsync's rdiff
or a casync run is converted but nonetheless, this creates some porting/
implementation and maintenance effort.


Kind regards,
   Christian

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany
