Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A5C7115C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 06:37:18 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.6349.1750818193183482822
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 19:23:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rowland.harvard.edu header.s=google header.b=ekSlY1AV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: g.harvard.edu, ip: 209.85.219.43, mailfrom: stern@g.harvard.edu)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fa980d05a8so10154006d6.2
        for <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750818192; x=1751422992; darn=lists.cip-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhVPhW6zAvMo92rhc/bflxjgJ9TsGXieNEe3ODAbCaM=;
        b=ekSlY1AVqamzbFFDxzPI3vO2ERnCfYIASwr643328jq0bA9Z7aTauYKi7pvrcadLLI
         XT2zDxZ4XuVLO14xg7i8b5jGzSojO8QgE9oNyhLa++a972Pm/wKkFDoaSK5eLQkIrS92
         l0BwfrtddEuAHuyOnAPzw6Be5T6jISAgSflJoZRX8lMehF9A+/zsI6b8WzdrXbyezwOk
         CBBmHlerpcHlzLfBJvq6lWGz9CRCv3SvMXZH959JS+uumK2XP7XKgoicmtXb1RhR3yol
         l6UzjpZqr2I2IY+ueMKJx4f44m6UkBbu3Fn6dSXPgJ5QJJc93TtGPSkSV40N7jSO/CGt
         /v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750818192; x=1751422992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhVPhW6zAvMo92rhc/bflxjgJ9TsGXieNEe3ODAbCaM=;
        b=WlMfbgwkL8aMvOpoXq5Ojgv7PbnhtyrrN/EZ+ru05v9uJhyIw4Q/xnzcG08RYu1d33
         1gqjekzqM2L0/u9+jZRqWwhEk+989rFuq/ldBO7qASbrU1PyzJ4Oi3LjJPlRWHkJi9ow
         9pgzPMqNY1fXDIgyFkvJKs3vY+xgVCgY605HVk3E3JQhA2LoBB2jTWLnkk72EveoJy8G
         1MPPa7M+tzHFZPVtnNvyRQvrbcon8Bo3ZeX+srKnrdyzFmerPgjz+vw5cd0EjIhidGHn
         9hzWOsfaWlybDwo/PRaoOeqI3gSroctz7IqOtssZ5zTMYnmLVnz1KOula5aFrNd6YJb2
         X9yg==
X-Gm-Message-State: AOJu0YyfuSlRS8UAj7MiCAjGqJz1ewifocfdc6bd1mttuv3jqYZnZEPp
	z4uMiHKMfe0KDZqgwTwmfABPGrqNCkskbcn8NlL8wRWmjDRcsUuWxO7eFcTpywMoOQ==
X-Gm-Gg: ASbGncvzCZcPw2IuM6ClPbJ6VGjT21xSEH3ZkOWc1u4fbkCwyGn93rn/qCrOg4hpFD2
	i8ZvN4MdiglsohenO4C62PaAtC3lrbo2RD2UlyTob0FMdYuOZJ9L+syUWe5PEryGroHCsaHUjU4
	0qFzowIPZ0j98lnMMUO+l9C2dGv17vbfCk7+KAeulnj3B2zubqIfIE8H2mnMKlQxUlW18Qk7Egj
	uvsnM0Jnll978SqzUy7DHAmdpnRc+lGxFD8+UzgVGdzJeYr24lJiUHxUNzYnCoBaepRayZCXHbH
	krFOpe+jrZZJf26B75CMoHhjzJdCrbyZa2j2+pf52Ul5JFZCWDPCzkCCRkZxG4M=
X-Google-Smtp-Source: AGHT+IF90HyR81uc5IHzklkKvJbHJLLUAtNNBbUQ9KJUQ3fycjUPEibTbX4sfUwdYIlH5lDfz+oMpA==
X-Received: by 2002:a05:6214:19c6:b0:6fa:9cdb:31a1 with SMTP id 6a1803df08f44-6fd5ef319d0mr17559236d6.1.1750818192146;
        Tue, 24 Jun 2025 19:23:12 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9ca8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09599c95sm63214026d6.106.2025.06.24.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 19:23:11 -0700 (PDT)
Date: Tue, 24 Jun 2025 22:23:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>,
	Pavel Machek <pavel@denx.de>, Bart Van Assche <bvanassche@acm.org>,
	Yi Zhang <yi.zhang@redhat.com>, stable@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
Message-ID: <8187ad4f-32e5-4768-8286-984c5b31845b@rowland.harvard.edu>
References: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
In-Reply-To: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jun 2025 06:37:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19231

On Wed, Jun 25, 2025 at 11:00:26AM +0900, Nobuhiro Iwamatsu wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.
> 
> Remove the /proc/scsi/${proc_name} directory earlier to fix a race
> condition between unloading and reloading kernel modules. This fixes a bug
> introduced in 2009 by commit 77c019768f06 ("[SCSI] fix /proc memory leak in
> the SCSI core").
> 
> Fix the following kernel warning:
> 
> proc_dir_entry 'scsi/scsi_debug' already registered
> WARNING: CPU: 19 PID: 27986 at fs/proc/generic.c:376 proc_register+0x27d/0x2e0
> Call Trace:
>  proc_mkdir+0xb5/0xe0
>  scsi_proc_hostdir_add+0xb5/0x170
>  scsi_host_alloc+0x683/0x6c0
>  sdebug_driver_probe+0x6b/0x2d0 [scsi_debug]
>  really_probe+0x159/0x540
>  __driver_probe_device+0xdc/0x230
>  driver_probe_device+0x4f/0x120
>  __device_attach_driver+0xef/0x180
>  bus_for_each_drv+0xe5/0x130
>  __device_attach+0x127/0x290
>  device_initial_probe+0x17/0x20
>  bus_probe_device+0x110/0x130
>  device_add+0x673/0xc80
>  device_register+0x1e/0x30
>  sdebug_add_host_helper+0x1a7/0x3b0 [scsi_debug]
>  scsi_debug_init+0x64f/0x1000 [scsi_debug]
>  do_one_initcall+0xd7/0x470
>  do_init_module+0xe7/0x330
>  load_module+0x122a/0x12c0
>  __do_sys_finit_module+0x124/0x1a0
>  __x64_sys_finit_module+0x46/0x50
>  do_syscall_64+0x38/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Can you or Bart please explain in more detail the race that causes this 
problem, and add that description to the changelog?  Also, explain how 
this patch fixes the race.

Alan Stern

> Link: https://lore.kernel.org/r/20230210205200.36973-3-bvanassche@acm.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 77c019768f06 ("[SCSI] fix /proc memory leak in the SCSI core")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/scsi/hosts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index c59b3fd6b361..7ffdebdd9c54 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -173,6 +173,7 @@ void scsi_remove_host(struct Scsi_Host *shost)
>  	scsi_forget_host(shost);
>  	mutex_unlock(&shost->scan_mutex);
>  	scsi_proc_host_rm(shost);
> +	scsi_proc_hostdir_rm(shost->hostt);
>  
>  	spin_lock_irqsave(shost->host_lock, flags);
>  	if (scsi_host_set_state(shost, SHOST_DEL))
> @@ -322,6 +323,7 @@ static void scsi_host_dev_release(struct device *dev)
>  	struct request_queue *q;
>  	void *queuedata;
>  
> +	/* In case scsi_remove_host() has not been called. */
>  	scsi_proc_hostdir_rm(shost->hostt);
>  
>  	if (shost->tmf_work_q)
> -- 
> 2.25.1
> 
> 

