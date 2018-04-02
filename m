From: Wes.Huang@moxa.com (=?utf-8?B?V2VzIEh1YW5nICjpu4Pmt7XmsrMp?=)
Date: Mon, 2 Apr 2018 05:34:07 +0000
Subject: [cip-dev] Kernel feature support
In-Reply-To: <000f01d3ca31$6dd091f0$4971b5d0$@toshiba.co.jp>
References: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
	<000f01d3ca31$6dd091f0$4971b5d0$@toshiba.co.jp>
Message-ID: <FAF29B5BFF9BF5439C88554EE7A20506F86B2924@MHQMBX02.moxa.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

Please refer to attached file. Thanks!

Hi Zoran,

Thanks for your kind reminder. Here is the new one.

Best regards, 

Wes Huang
Software R&D
Moxa Systems
Tel : 886-2-8919-1230 Ext.7718
Fax: 886-2-8919-1231
Wes.Huang at moxa.com

This email and any attached files may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this email. Any unauthorized duplication, utilization, disclosure, or distribution of the material in this email and its attached files is strictly forbidden. 


-----Original Message-----
From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp] 
Sent: Monday, April 02, 2018 11:20 AM
To: Wes Huang (???); cip-dev at lists.cip-project.org
Subject: RE: [cip-dev] Kernel feature support

Dear Wes,

Could you use generate a defconfig from your .config to see the options that you have enabled or modified more clearly?

$ make savedefconfig
$ less defconfig

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org 
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Wes Huang 
> (???)
> Sent: Saturday, March 31, 2018 4:56 PM
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Kernel feature support
> 
> Hi,
> 
> 
> 
> Sorry for the late reply.
> 
> 
> 
> Please find attached a Moxa kernel configuration using CIP kernel 4.4.
> 
> 
> 
> Best regards,
> 
> 
> 
> Wes Huang
> 
> Software R&D
> 
> Moxa Systems
> 
> Tel : 886-2-8919-1230 Ext.7718
> 
> Fax: 886-2-8919-1231
> 
> Wes.Huang at moxa.com
> 
> 
> This email and any attached files may contain confidential and/or 
> privileged information. If you are not the intended recipient (or have 
> received this e-mail in error) please notify the sender immediately and destroy this email. Any unauthorized duplication, utilization, disclosure, or distribution of the material in this email and its attached files is strictly forbidden.
> 
> 



-------------- next part --------------
A non-text attachment was scrubbed...
Name: moxa_defconfig
Type: application/octet-stream
Size: 27984 bytes
Desc: moxa_defconfig
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180402/75b95ba4/attachment-0001.obj>
