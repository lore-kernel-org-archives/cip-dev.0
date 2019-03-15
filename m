From: akihiro27.suzuki@toshiba.co.jp (Akihiro Suzuki)
Date: Fri, 15 Mar 2019 15:38:33 +0900
Subject: [cip-dev] isar-cip-core: Fix lack of console option when starting
	qemu-amd64 with nographic
Message-ID: <20190315063834.3788-1-akihiro27.suzuki@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I have added "console=ttyS0" to the kernel command line to be able to
see a serial output when starting qemu-amd64 with nographic.

  [PATCH] Add a console option to the kernel command line

I have already made a merge request in GitLab before sending this e-mail.
If it's not in line with the workflow of isar-cip-core, please close it.
<https://gitlab.com/cip-project/cip-core/isar-cip-core/merge_requests/1>

Best regards,
Suzuki
