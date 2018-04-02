From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 2 Apr 2018 12:19:36 +0900
Subject: [cip-dev] Kernel feature support
In-Reply-To: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
References: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
Message-ID: <000f01d3ca31$6dd091f0$4971b5d0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Wes,

Could you use generate a defconfig from your .config to see the options that you have enabled or modified more clearly?

$ make savedefconfig
$ less defconfig

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Wes Huang (???)
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
> This email and any attached files may contain confidential and/or privileged information. If you are not the intended recipient (or have
> received this e-mail in error) please notify the sender immediately and destroy this email. Any unauthorized duplication, utilization,
> disclosure, or distribution of the material in this email and its attached files is strictly forbidden.
> 
> 
