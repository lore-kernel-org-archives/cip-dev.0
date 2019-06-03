From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Mon, 3 Jun 2019 07:41:59 +0000
Subject: [cip-dev] [isar-cip-core] kernel: add yml file for 4.19 kernels
In-Reply-To: <7d35c0d9-648c-20b8-23fa-fa4e3a0c18de@siemens.com>
References: <20190603072531.28135-1-daniel.sangorrin@toshiba.co.jp>
	<7d35c0d9-648c-20b8-23fa-fa4e3a0c18de@siemens.com>
Message-ID: <TY2PR01MB33238C2EC3FC81F6234A0B94D0140@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> > +local_conf_header:
> > +  kernel-version: |
> > +    PREFERRED_VERSION_linux-cip = "4.19.%"
> > +    PREFERRED_VERSION_linux-cip-rt = "4.19.%"
> >
> 
> Thanks for looking into that - was (too) long on my todo list.
> 
> I would just turn the default around and make 4.4 opt-in.

OK, patch sent!

Thanks,
Daniel


> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
