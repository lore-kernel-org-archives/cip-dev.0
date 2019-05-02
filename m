From: laurence.urhegyi@codethink.co.uk (Laurence Urhegyi)
Date: Thu, 02 May 2019 19:18:22 +0100
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
 list
In-Reply-To: <16205208.VlgFrJl6Ko@linux-3zh6>
References: <16205208.VlgFrJl6Ko@linux-3zh6>
Message-ID: <ce12a60d5f0ccf3a81ec28c856fbfb0a@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

The list attached to the below mail has been reviewed internally at 
Codethink: no strong opinions from us.

Kind regards,
Laurence


> ----------  Forwarded Message  ----------
> 
> Subject: [cip-dev] [cip-core] RFC: Process to decide supported package 
> list
> Date: Tuesday, 16 April 2019, 15:22:00 CEST
> From: kazuhiro3.hayashi at toshiba.co.jp
> To: cip-dev at lists.cip-project.org
> 
> Hello CIP developers,
> 
> I would like to suggest an idea about the process to determine the 
> package
> list that should be supported by CIP.
> It's difficult to discuss adding any packages including their 
> dependencies
> from whole Debian, mixing the two profiles.
> 
> As the first step, it would be better to start from the source package 
> list
> which binary packages are installed by debootstrap minbase.
> I attached the source package list, where only 58 packages exist.
> I guess that it's easier to discuss which packages should be supported 
> from
> such core components.
> 
> NOTE: busybox is not included in the attached list, but it have to be
> supported
> not only for the tiny profile but also initramfs (and Debian 
> installer?) in
> the generic profile.
> 
> Regarding the tiny profile, we need to keep discussion about which 
> busybox
> applet should be supported.
> I think this process should be done independently from the above 
> discussion
> because
> the all packages selected from debootstrap in the first step should be
> supported in the tiny profile as well.
> 
> Regarding voting, I have the same opinion that Daniel proposed 
> previously.
> 	1. Send an initial list and vote (>50% means accepted)
> 	2. After that, each package will be voted (>50% means accepted)
> 
> As the second step, we consider adding other packages not included in 
> the list
> one by one.
> We need to decide the detailed process of the second step later.
> 
> If you have any other opinions, please let me know.
> 
> Kind regards,
> Kazu
> 
>  Kazuhiro Hayashi
>  Corporate Software Engineering & Technology Center
>  Toshiba Corporation
>  Tel: +81-44-549-2476
>  E-mail: kazuhiro3.hayashi at toshiba.co.jp
> 
> 
> -----------------------------------------
