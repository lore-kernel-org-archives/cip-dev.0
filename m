From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 24 Apr 2019 00:58:39 +0000
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
	list
In-Reply-To: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB41896A8C7559CF24EC798ABF923C0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

+1
I think it is better to proceed this way.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of
> kazuhiro3.hayashi at toshiba.co.jp
> Sent: Tuesday, April 16, 2019 10:22 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
> list
> 
> Hello CIP developers,
> 
> I would like to suggest an idea about the process to determine the package
> list that should be supported by CIP.
> It's difficult to discuss adding any packages including their
> dependencies from whole Debian, mixing the two profiles.
> 
> As the first step, it would be better to start from the source package
> list which binary packages are installed by debootstrap minbase.
> I attached the source package list, where only 58 packages exist.
> I guess that it's easier to discuss which packages should be supported
> from such core components.
> 
> NOTE: busybox is not included in the attached list, but it have to be
> supported not only for the tiny profile but also initramfs (and Debian
> installer?) in the generic profile.
> 
> Regarding the tiny profile, we need to keep discussion about which busybox
> applet should be supported.
> I think this process should be done independently from the above
> discussion because the all packages selected from debootstrap in the first
> step should be supported in the tiny profile as well.
> 
> Regarding voting, I have the same opinion that Daniel proposed previously.
> 	1. Send an initial list and vote (>50% means accepted)
> 	2. After that, each package will be voted (>50% means accepted)
> 
> As the second step, we consider adding other packages not included in
> the list one by one.
> We need to decide the detailed process of the second step later.
> 
> If you have any other opinions, please let me know.
> 
> Kind regards,
> Kazu
> 
>  Kazuhiro Hayashi
>  Corporate Software Engineering & Technology Center  Toshiba
> Corporation
>  Tel: +81-44-549-2476
>  E-mail: kazuhiro3.hayashi at toshiba.co.jp
> 
