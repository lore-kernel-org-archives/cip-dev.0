From: akihiro27.suzuki@toshiba.co.jp (Akihiro Suzuki)
Date: Wed,  3 Apr 2019 17:33:22 +0900
Subject: [cip-dev] [PATCH v2 isar-cip-core/master] start-qemu.sh: Set
	console when using qemu-amd64 with nographic
In-Reply-To: <12bc282f-e95c-85a6-9919-674beb32fa13@siemens.com>
References: <12bc282f-e95c-85a6-9919-674beb32fa13@siemens.com>
Message-ID: <20190403083323.21613-1-akihiro27.suzuki@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

Sorry for my late reply.

I have created a new patch.
After applying the patch, "console=ttyS0" is added to KERNEL_CMDLINE
only when you use qemu-system-x86_64 with "-nographic" option.

Best regards,
Suzuki
