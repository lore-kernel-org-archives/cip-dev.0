From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 18 Mar 2019 07:22:37 +0100
Subject: [cip-dev] [PATCH] Add a console option to the kernel command
	line
In-Reply-To: <TY2PR01MB51468E02C4A674214EB1768BD9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
References: <20190315063834.3788-1-akihiro27.suzuki@toshiba.co.jp>
	<20190315063834.3788-2-akihiro27.suzuki@toshiba.co.jp>
	<a724b46c-3c8f-fe67-546a-d036dac80c7d@siemens.com>
	<TY2PR01MB51468E02C4A674214EB1768BD9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
Message-ID: <12bc282f-e95c-85a6-9919-674beb32fa13@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 18.03.19 06:55, akihiro27.suzuki at toshiba.co.jp wrote:
> Hi Jan,
> 
> I agree with your opinion.
> We have to be able to use a uart console even if DISPLAY has a value.
> 
> But I couldn't understand the statement of "That's how it is on ARM[64] already".
> Could you explain it in more detail?
> Do you mean that, on ARM[64], we don't have to add console option to KERNEL_CMDLINE
> on current start-qemu.sh?

On ARM, QEMU ensures that the guest uses the UART by injecting this as console 
into its device tree. This mechanism is not available on the x86 boot, therefore 
we need to set this on the command line.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
