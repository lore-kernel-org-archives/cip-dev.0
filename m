X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web09.5150.1644969056763355673
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Feb 2022 15:50:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OUWwvjlO;
 spf=pass (domain: gmail.com, ip: 209.85.216.44, mailfrom: masami256@gmail.com)
Received: by mail-pj1-f44.google.com with SMTP id om7so866936pjb.5
        for <cip-dev@lists.cip-project.org>; Tue, 15 Feb 2022 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnaJAOyANRsvHgLjOZ0mZdBEgEpxIJfQBL5MTEYycqM=;
        b=OUWwvjlOfRsEQRQy/8gi6Ypu4Im7cml1hJD9k3q6gtAMH6knOsnaUMmoJTeU2mJ8a8
         BBbtBMPRqLn72zd6PPF/aBFSsxcQ7G7UnTyjEQQyAVAEqzjcJH2P4rmOlv9O2iW/+kOY
         Ej9GYWjTkxpZDjN23zE8fQRo+p/Za7eKUDfVAJAnugAYcDjXill+YQKmF3LStgX+tuJT
         5CU9C+hc6WzVPU1oBk7hcgus+yfo2z1U35Km5ZwY2mBjV9RCg6SeTMH0tjgbMM7Uu+ez
         m68d9QhpkI4+5LMPLLtPzn5WOgIiiBbgtwbwSozyZef9T27SgHcqlWSuo1xQkfBa7EBp
         4sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnaJAOyANRsvHgLjOZ0mZdBEgEpxIJfQBL5MTEYycqM=;
        b=Vm051jVDPxQxQOq7ZGyxo21oACWTywZojw1zCsrPeZfPntJS91HLnJdUR2CraORyLq
         lUL/TW3hzfKmuUTCjG4m1KJmabL8jumhTYS7l0PKqxkVclN8fAwYyi+nRDdsghOS6QSy
         NNmY/9DRrwDw5S/cCrfUk1LSMZV0NRRc7HzaZUS7BnXpcl27sshJkK8SMSyD4u1Nx3Zn
         lckB3//j8TxDs3yJT7zydksALZcwby4gLkKTpy25rYn9oczm9o1kcr73KRXF6shjWLSy
         z14Yo76N6u3c9+ENRYe8R85lzU1P4cwIaT/llnrMGj1lbHIndorthki/wVK/mltfIOsP
         8fjg==
X-Gm-Message-State: AOAM532QMVe+1nOVLvFg+zsgfsycdMluQUVIYDxLFmWMmoDt8VGTb7zX
	XVpcdeKvCF5Dit7EQkYFWI3WHrK4S0yrBQ==
X-Google-Smtp-Source: ABdhPJzqnQlN9Cs7d/OIj4JGQ5BCYCuD/AC6v0AsjYpcdzJ04laMfuOy5K2IM/tN2rz09UsnD2x5NA==
X-Received: by 2002:a17:902:e94c:: with SMTP id b12mr1401267pll.161.1644969055909;
        Tue, 15 Feb 2022 15:50:55 -0800 (PST)
Return-Path: <masami256@gmail.com>
Received: from moon.. (FL1-110-233-204-67.tky.mesh.ad.jp. [110.233.204.67])
        by smtp.gmail.com with ESMTPSA id x34sm4930379pfh.178.2022.02.15.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 15:50:54 -0800 (PST)
From: "Masami Ichikawa" <masami256@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tabitha Sable <tabitha.c.sable@gmail.com>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masami Ichikawa <masami.ichikawa@cybertrust.co.jp>
Subject: [PATCH for 4.4.y-cip] cgroup-v1: Require capabilities to set release_agent
Date: Wed, 16 Feb 2022 08:40:37 +0900
Message-Id: <20220215234036.19800-1-masami256@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 24f6008564183aa120d07c03d9289519c2fe02af upstream.

The cgroup release_agent is called with call_usermodehelper.  The function
call_usermodehelper starts the release_agent with a full set fo capabilitie=
s.
Therefore require capabilities when setting the release_agaent.

Reported-by: Tabitha Sable <tabitha.c.sable@gmail.com>
Tested-by: Tabitha Sable <tabitha.c.sable@gmail.com>
Fixes: 81a6a5cdd2c5 ("Task Control Groups: automatic userspace notification=
 of idle cgroups")
Cc: stable@vger.kernel.org # v2.6.24+
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[mkoutny: Adjust for pre-fs_context, duplicate mount/remount check, drop lo=
g messages.]
Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[masami: Backport patch from 4.9. Adjust to use current_user_ns() to get cu=
rrent user_ns.
Fix conflict in cgroup_release_agent_write().]
Reference: CVE-2022-0492
Signed-off-by: Masami Ichikawa(CIP) <masami.ichikawa@cybertrust.co.jp>
---
 kernel/cgroup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index 1f5e7dcbfd40..af521a3da21c 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -1786,6 +1786,13 @@ static int cgroup_remount(struct kernfs_root *kf_roo=
t, int *flags, char *data)
 		pr_warn("option changes via remount are deprecated (pid=3D%d comm=3D%s)\=
n",
 			task_tgid_nr(current), current->comm);
=20
+	/* See cgroup_mount release_agent handling */
+	if (opts.release_agent &&
+	    ((current_user_ns() !=3D &init_user_ns) || !capable(CAP_SYS_ADMIN))) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
 	added_mask =3D opts.subsys_mask & ~root->subsys_mask;
 	removed_mask =3D root->subsys_mask & ~opts.subsys_mask;
=20
@@ -2135,6 +2142,16 @@ static struct dentry *cgroup_mount(struct file_syste=
m_type *fs_type,
 		goto out_unlock;
 	}
=20
+	/*
+	 * Release agent gets called with all capabilities,
+	 * require capabilities to set release agent.
+	 */
+	if (opts.release_agent &&
+	    ((current_user_ns() !=3D &init_user_ns) || !capable(CAP_SYS_ADMIN))) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
 	root =3D kzalloc(sizeof(*root), GFP_KERNEL);
 	if (!root) {
 		ret =3D -ENOMEM;
@@ -2839,6 +2856,14 @@ static ssize_t cgroup_release_agent_write(struct ker=
nfs_open_file *of,
=20
 	BUILD_BUG_ON(sizeof(cgrp->root->release_agent_path) < PATH_MAX);
=20
+	/*
+	 * Release agent gets called with all capabilities,
+	 * require capabilities to set release agent.
+	 */
+	if ((of->file->f_cred->user_ns !=3D &init_user_ns) ||
+		!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
 	cgrp =3D cgroup_kn_lock_live(of->kn);
 	if (!cgrp)
 		return -ENODEV;
--=20
2.35.1


