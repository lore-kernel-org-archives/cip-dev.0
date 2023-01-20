Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A8FC05027
	for <webhook@archiver.kernel.org>; Fri, 20 Jan 2023 14:22:28 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.75171.1674224486853256000
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Jan 2023 06:21:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=jfjbZD97;
 spf=pass (domain: kernel.org, ip: 139.178.84.217, mailfrom: broonie@kernel.org)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F0E1961F5F;
	Fri, 20 Jan 2023 14:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4F1C433AA;
	Fri, 20 Jan 2023 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674224485;
	bh=O2DLXPO6MhsyTB89fm7zdE+nWTN52RPQ1lrd1S6Urk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jfjbZD97KEtplE21rjRbIcyoiwp5hrkruQsWya6xv6RQci0elOvNi5Ifmzbr2RVdF
	 wURh1Rv2KBUZr2DXAwio5iDiaVARvDfl44X7swPAYttuY1syxPoz4mE5ivXgmXg96P
	 0R9qM8eqjtymzsjW4SLibjSbBPk5RWE84xWr9czyfp11C46icQH1WBDzgKsT0zjrLb
	 eb9kLXDf1H7z1qxlexKGQ6/7bX7x2Zn5laDebck6bsFRjI5rNv4dvDhh/0/inBxJpt
	 W7B4Z2HKXOYDIT6cVRtN+3eSPjUtZ45o2hhL62wSJpDaXQAScJhgGFUufLSC96o7vh
	 qHkWYq0vd7b1A==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Dan Carpenter <error27@gmail.com>
Cc: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Rander Wang <rander.wang@intel.com>, 
 sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org, 
 kernel-janitors@vger.kernel.org, "cip-dev" <cip-dev@lists.cip-project.org>, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <Y8laruWOEwOC/dx9@kili>
References: <Y8laruWOEwOC/dx9@kili>
Subject: Re: [PATCH] ASoC: SOF: ipc4-mtrace: prevent underflow in sof_ipc4_priority_mask_dfs_write()
Message-Id: <167422448135.1273927.7280697250336650251.b4-ty@kernel.org>
Date: Fri, 20 Jan 2023 14:21:21 +0000
MIME-Version: 1.0
X-Mailer: b4 0.12-dev-77e06
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jan 2023 14:22:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10454

On Thu, 19 Jan 2023 17:58:54 +0300, Dan Carpenter wrote:
> The "id" comes from the user.  Change the type to unsigned to prevent
> an array underflow.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-mtrace: prevent underflow in sof_ipc4_priority_mask_dfs_write()
      commit: ea57680af47587397f5005d7758022441ed66d54

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


