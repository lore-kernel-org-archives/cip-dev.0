From: quirin.gylstorff@siemens.com (Gylstorff Quirin)
Date: Thu, 7 Nov 2019 16:53:48 +0100
Subject: [cip-dev] [isar-cip-core PATCH 3/4] hihope-rzg2m: Add board
 support
In-Reply-To: <TYAPR01MB4286445DBFE0BE6FD3D9CC49E1780@TYAPR01MB4286.jpnprd01.prod.outlook.com>
References: <20191106124439.10532-1-Quirin.Gylstorff@siemens.com>
	<20191106124439.10532-4-Quirin.Gylstorff@siemens.com>
	<TYAPR01MB2285255EF4A6521577D5F789B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<66a2849e-bbf8-7e67-0da3-490b052f18cb@siemens.com>
	<TYAPR01MB4286445DBFE0BE6FD3D9CC49E1780@TYAPR01MB4286.jpnprd01.prod.outlook.com>
Message-ID: <d41024b8-0d3f-a4e6-fef3-76dc350dfc62@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



On 11/7/19 3:29 AM, kazuhiro3.hayashi at toshiba.co.jp wrote:
> Hello Quirin,
> 
>> I will look into it using the cip-kernel-config instead of using copies
>> in isar.
> 
> Are you planning to "fetch" required config(s) for each target from cip-kernel-config?
> or, keep copies of the configs in isar-cip-core then synchronize them at the specific point?

I try to fetch the configuration for each target from cip-kernel-config.
Currently I need to patch the config as Isar doesn't allow setting  
CONFIG_LOCALVERSION in the kernel configuration.

> 
> Deby also has its own kernel configs (arm64 defconfig + Tiny hihope-rzg2m.config)
> for HiHope RZG2M:
> https://gitlab.com/cip-project/cip-core/deby/blob/cip-core-buster/meta-hihope-rzg2m/recipes-kernel/linux/linux-base_git.bbappend
> but they also should be replaced by the common kernel configs in CIP.
> As the first step, I would provide configs by the same way as isar-cip-core.
> 
> Best regards,
> Kazu
> 
> 

Quirin
