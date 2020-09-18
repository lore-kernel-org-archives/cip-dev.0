Return-Path: <SRS0=tt23=C3=lists.cip-project.org=bounce+64572+5461+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12547C43463
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 04:53:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3672F21481
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 04:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cQas3M34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3672F21481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5461+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AcLPYY4521723xtVeUDJz4oW; Thu, 17 Sep 2020 21:53:41 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web12.6091.1600404819771556859
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2020 21:53:40 -0700
IronPort-SDR: ynu+ntKgXDMxLwcDaXKkZOI9PNSOJdSTs7P2dsdQIIOb+cOCBTuh4HuEe42mMXuJsRMnKr9ZBr
 peF2jqCuAPwQ==
X-IronPort-AV: E=Sophos;i="5.77,273,1596479400"; 
   d="scan'208";a="6317644"
X-Received: from unknown (HELO TOSBLRMBX0219.TOSHIBA-TSIP.COM) ([172.28.80.119])
  by peak.toshiba-tesi.com with ESMTP; 18 Sep 2020 11:04:37 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 10:23:26 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::21bd:a752:e362:9dd9]) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM ([fe80::21bd:a752:e362:9dd9%4]) with mapi id
 15.01.1847.003; Fri, 18 Sep 2020 10:23:26 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: "daniel.sangorrin@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [cip-core:deby 2/3] security-configuration: apply security polcies using package bbappend
Thread-Topic: [cip-core:deby 2/3] security-configuration: apply security
 polcies using package bbappend
Thread-Index: AQHWi2u46TUwVz9swE+h2Hixe4LQvalsG64AgAG7C+A=
Date: Fri, 18 Sep 2020 04:53:26 +0000
Message-ID: <ae0a8274c42447e59694998d04c7c519@toshiba-tsip.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
 <20200915142345.179-3-venkata.pyla@toshiba-tsip.com>
 <OSBPR01MB20537A78A4552A894CC11207D03E0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB20537A78A4552A894CC11207D03E0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.80.121]
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1Wzz2elu4pJSrWww29MXuLR1x4520388AA=
Content-Type: multipart/mixed; boundary="zehs38yjodJpEgemcRZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600404821;
 bh=y8ujI5N2J2EoxR09y+XbQ2+m6XoViYHztj37Sbu3RaU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=cQas3M34j3S1y3680Ugvf+mJDPFHLsT5dp/l++DR5s7QHiOPLi3ltYWqYugLPtdX4Ft
 PeiaA39whXotliq16CwWClNmTPY5guI/o0j4gWoIGm7nnNUG35iJMfVcc0vVWH0ZLGKm2
 SV5+GLl/jK4aT2sdHhqo7SZBPquAHvWGHK4=

--zehs38yjodJpEgemcRZA
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

HI Daniel-san,

Thank you for your feedback.

sorry for spell checks issues in the commits, I will correct it and send an=
other merge request.
Also I will apply other security configuration suggestions.

Thanks
Venkata.

-----Original Message-----
From: daniel.sangorrin@toshiba.co.jp <daniel.sangorrin@toshiba.co.jp> =

Sent: 17 September 2020 08:32
To: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>
Cc: Venkata Seshagiri Pyla <Venkata.Pyla@toshiba-tsip.com>; cip-dev@lists.c=
ip-project.org
Subject: RE: [cip-core:deby 2/3] security-configuration: apply security pol=
cies using package bbappend

Hi Venkata-san

Please check my inline comments and send me a merge request when you solve =
them.

> -----Original Message-----
> From: venkata.pyla@toshiba-tsip.com <venkata.pyla@toshiba-tsip.com>
> Sent: Tuesday, September 15, 2020 11:24 PM
> To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#=
C"~#A#C#T=1B(B) =

> <daniel.sangorrin@toshiba.co.jp>
> Cc: pyla venkata(=1B$B#T#S#I#P=1B(B) <Venkata.Pyla@toshiba-tsip.com>; =

> cip-dev@lists.cip-project.org
> Subject: [cip-core:deby 2/3] security-configuration: apply security =

> polcies using package bbappend
> =

> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> =

> add package bbappaned files in the security layer that will apply

bbappend

> the security configurations like
>     e.g: Set password strength in pam configurations
>          Set audit failure actions in audit package configurations
>          etc.
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .../audit/audit_debian.bbappend               | 20 ++++++++++
>  .../base-files/base-files_debian.bbappend     |  3 ++
>  .../openssh/openssh_debian.bbappend           | 19 +++++++++
>  .../recipes-debian/pam/libpam_debian.bbappend | 39 =

> +++++++++++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 =

> meta-cip-security/recipes-debian/audit/audit_debian.bbappend
>  create mode 100644 =

> meta-cip-security/recipes-debian/base-files/base-files_debian.bbappend
>  create mode 100644 =

> meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend
>  create mode 100644 =

> meta-cip-security/recipes-debian/pam/libpam_debian.bbappend

Ideally, you would separate the patches for each file unless they have some=
thing in common.
 =

> diff --git =

> a/meta-cip-security/recipes-debian/audit/audit_debian.bbappend =

> b/meta-cip-security/recipes- debian/audit/audit_debian.bbappend
> new file mode 100644
> index 0000000..c148f27
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/audit/audit_debian.bbappend
> @@ -0,0 +1,20 @@
> +#
> +# CIP Security, tiny profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020 # # =

> +SPDX-License-Identifier: MIT #
> +
> +DESCRIPTION =3D "CIP Security customizations"
Append "for audit" to the description.

> +
> +pkg_postinst_audit_append() {
> +	# CR2.9: Audit storage capacity
> +	# CR2.9 RE-1: Warn when audit record storage capacity threshold reached
> +	AUDIT_CONF_FILE=3D"$D${sysconfdir}/audit/auditd.conf"
> +	sed -i 's/space_left_action =3D .*/space_left_action =3D SYSLOG/'  $AUD=
IT_CONF_FILE
> +	sed -i 's/admin_space_left_action =3D .*/admin_space_left_action =3D =

> +SYSLOG/' $AUDIT_CONF_FILE

Don't you need to specify the values for space_left and admin_space_left?
Perhaps these variables should be configurable  and have a default value.
Example:
AUDIT_SPACE_LEFT ?=3D "100"

Then you can change the value in local.conf (or using kas's local_conf_head=
ers)

> +
> +	# CR2.10: Response to audit processing failures
> +	sed -i 's/disk_error_action =3D .*/disk_error_action =3D SYSLOG/' =

> +$AUDIT_CONF_FILE }

Please check if you need other options as well here:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/ht=
ml/security_guide/sec-configuring_the_audit_service

> diff --git =

> a/meta-cip-security/recipes-debian/base-files/base-files_debian.bbappe
> nd b/meta-cip-security/recipes-debian/base-
> files/base-files_debian.bbappend
> new file mode 100644
> index 0000000..895dc9f
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/base-files/base-files_debian.bb
> +++ append
> @@ -0,0 +1,3 @@
> +do_install_append() {
> +	echo "${MACHINE}" > ${D}${sysconfdir}/hostname }

Is this related to the security layer?
If not, please separate it into a different patch and explain why it is nec=
essary.

> diff --git =

> a/meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend =

> b/meta-cip-security/recipes- debian/openssh/openssh_debian.bbappend
> new file mode 100644
> index 0000000..ddd2bfc
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend
> @@ -0,0 +1,19 @@
> +#
> +# CIP Security, tiny profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020 # # =

> +SPDX-License-Identifier: MIT #
> +
> +DESCRIPTION =3D "CIP Security customizations"

Same as before, append "for openssh". The description for different things =
should be different.

> +
> +pkg_postinst_${PN}_append() {
> +	# CR2.6: Remote session termination
> +	# Terminate remote session after inactive time period
> +	SSHD_CONFIG=3D"$D${sysconfdir}/ssh/sshd_config"
> +	alive_interval=3D$(sed -n '/ClientAliveInterval/p' "${SSHD_CONFIG}")
> +	alive_countmax=3D$(sed -n '/ClientAliveCountMax/p' "${SSHD_CONFIG}")
> +	sed -i "/${alive_interval}/c ClientAliveInterval 120"  "${SSHD_CONFIG}"
> +	sed -i "/${alive_countmax}/c ClientAliveCountMax 0" "${SSHD_CONFIG}"

Perhaps make the value for ClientAliveInterval configurable and use 120 as =
default.

> +}
> diff --git =

> a/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend =

> b/meta-cip-security/recipes- debian/pam/libpam_debian.bbappend new =

> file mode 100644 index 0000000..c9c1605
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend
> @@ -0,0 +1,39 @@
> +#
> +# CIP Security, tiny profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020 # # =

> +SPDX-License-Identifier: MIT #
> +
> +DESCRIPTION =3D "CIP Security customizations"

Same thing: "for libpam"

> +
> +pkg_postinst_pam-plugin-cracklib_append() {
> +	# CR1.7: Strength of password-based authentication
> +	# Pam configuration to  enforce password strength
> +	PAM_PWD_FILE=3D"$D${sysconfdir}/pam.d/common-password"
> +	CRACKLIB_CONFIG=3D"password  requisite    pam_cracklib.so retry=3D3 min=
len=3D8 maxrepeat=3D3 ucredit=3D-1 lcredit=3D-1 dcredit=3D-1
> ocredit=3D-1 difok=3D3 gecoscheck=3D1 reject_username enforce_for_root"
> +	if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
> +		sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
> +	fi
> +	sed -i "0,/^password.*/s/^password.*/${CRACKLIB_CONFIG}\n&/" "${PAM_PWD=
_FILE}"
> +}

Perhaps set minlen configurable.

> +
> +pkg_postinst_pam-plugin-tally2_append() {
> +	# CR1.11: Unsuccessful login attempts
> +	# Lock user account after unsuccessful login attempts
> +	PAM_AUTH_FILE=3D"$D${sysconfdir}/pam.d/common-auth"
> +	pam_tally=3D"auth   required  pam_tally2.so  deny=3D3 even_deny_root un=
lock_time=3D60 root_unlock_time=3D60"
> +	if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
> +        	sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
> +	fi
> +	sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
> +}
> +
> +
> +pkg_postinst_libpam_append() {
> +	# CR2.7: Concurrent session control
> +	# Limit the concurrent login sessions
> +	LIMITS_CONFIG=3D"$D${sysconfdir}/security/limits.conf"
> +	echo "* hard maxlogins 2" >> ${LIMITS_CONFIG} }

Thanks,
Daniel
The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the =

recipient and may contain privileged information. =

If you are not the intended recipient, please notify the
sender and delete the message along with any =

attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail =

are those of the individual sender except where the sender =

specifically states them to be the views of =

Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer =

system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility =

is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--zehs38yjodJpEgemcRZA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5461): https://lists.cip-project.org/g/cip-dev/message=
/5461
Mute This Topic: https://lists.cip-project.org/mt/76865928/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zehs38yjodJpEgemcRZA--
