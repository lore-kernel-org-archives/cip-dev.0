Return-Path: <SRS0=S646=C2=lists.cip-project.org=bounce+64572+5457+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A085C433E2
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 03:02:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C2D2075E
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 03:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="okunVZed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C2D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5457+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0eBJYY4521723xoudf2SiOPG; Wed, 16 Sep 2020 20:02:21 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.7319.1600311737945517672
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2020 20:02:19 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08H32FXm018395; Thu, 17 Sep 2020 12:02:16 +0900
X-Iguazu-Qid: 34tMJPQpiME2AoU0dX
X-Iguazu-QSIG: v=2; s=0; t=1600311735; q=34tMJPQpiME2AoU0dX; m=e7rfSj1IcpwNH6xsiyW/305GgmFvTy8DctDNabX+I9Q=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 08H32EMP032461;
	Thu, 17 Sep 2020 12:02:15 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08H32EsJ004773
	for <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2020 12:02:14 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08H32EhZ017685
	for <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2020 12:02:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDAHUtW/oMkOilBkL6TQl+EekpUECnyqkbu9oqoqBGrHcGiE+bmlldqu4rwCo95Pv/nQTh1urcSBQ4GPqVDQOXjjs//mkDPW/RcDaTYYy73wdAfh8EdE1T8el/vt9/jXGIuUI6lH5ZAsT7HZQPBNPxdHhVeKwB11gcpL4B8BrxwpEICXY4OhzRq3UKsw5H0yAZCtC2Krmpgr8YkCfcOZbNCinX9H1LAyRBg5JrJ4BZEmoZMGIbP2iYAE8oJoQ0IKctzzzLXJi+mZnby6q9ULZGOWTEiGv32KqH5EMrrz2mLa4MEN2oq/Jg+ccJtWoPrOaLKNH2sl8nEHSWFwDzl/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEZVu1IvD7/I57r9HCxZaFTLrbkbwkHh7+OIkQe1QIU=;
 b=a6ODYG7l60ifpR45N6+1OJRNm4pwlueCxbaybsRPdDw+r+AKjMNIWmGI58aq0Eb72rii5WSOw0F4Iv3ATCm8vGYHuEt1xk2Lx/drhb6M6TEke3GH5YRKm5x1JnI3OlOgtXpeQCLa3tym2he6Jsu07BJWwyOinl3WkBOmkPDwiTYdjKYGzguhszEp0DNUfANw0hkxufAhFa1DNVKDpagCeIuqOTSDZAPuGY9fOVMXyqYVAotfo5RYpWO8F4Zy3WCQFMhhqDBSsKhOeJYfSiBIyPMqIZVKD+npy7N46/nUhu0rf8jvG7tXNMwkWJchkaXe565w2oq2FGbB7Y9d79i5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <Venkata.Pyla@toshiba-tsip.com>
CC: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [cip-core:deby 2/3] security-configuration: apply security polcies using package bbappend
Thread-Topic: [cip-core:deby 2/3] security-configuration: apply security
 polcies using package bbappend
Thread-Index: AQHWi2u46TUwVz9swE+h2Hixe4LQvalsG64A
Date: Thu, 17 Sep 2020 03:02:12 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20537A78A4552A894CC11207D03E0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
 <20200915142345.179-3-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200915142345.179-3-venkata.pyla@toshiba-tsip.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ac4d49-4354-48a1-4f2f-08d85ab61372
x-ms-traffictypediagnostic: OSBPR01MB3397:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB3397DE21F6918B3B6BDD2DCED03E0@OSBPR01MB3397.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JfrvT1xQnpEOKU4MkN+d/rm4LjasH8p6vdFsxe4U5ykWLPg9biG8mWwApDzhTjFrkNiyui4V2KheOcErl7qbyrRdHE+dBoAq4HUFf3eMzIxaDL0jTa3WB+9R2zCH0mGXXesO40mmJ6sUH6PXRHJhjVNxu2hoLvL1yflE8KZQDVSOO9Av+KG/mFIJvkyoPrs9bAVe/T8dt++GWQyJk+2xxq5QlxTcjLmDrFb/ypPTVpmsSzWw079z3bcX4H4rK3VIzORXviNiRY4FWMoTarQKrVcEK3leP0blPmNQFpxfoIMFe0yPonkfwJTrs/SmUDRnrrM5nwcpfXG/EQuNEmYbog2MI8PyfgiVuXnfu5c/1PXa2Da78csDZTD3jB6I2x/Vy7/lB6iqaOUOZFT0TpBQP/8LASoHrU+q5TTJpSsMCYzJGQIOrck6DEE2GqSulE/PvfyUIvF+DV05VM1qs1FDCQ==
x-ms-exchange-antispam-messagedata: YR3jbPqSYeSklvmo7VikaZvCPVrR4o95xIc5G3jD5NdYDA+1s0BkYrvWzWnbh5bz1IHo07z+0vkRy8AmNbNmav1I8k2iNnUyZZY0CsTj2deiJJr4KkM9O1NB7DodHyvPLQT50cYhS5uvL06AA4DM5HJ+C/9IaIo7qtUU1G9nINWaNXtbyGPfrozcKNe42ZodnF3AJNxcr0m2HPi/0RjblImCEFHHnNXD/TvBxMlVYFUq8hivz1JdG+/bCSmwUVAWiaVAMg/H8yejZoEZcNEL7XzXG65akD0qkDD0YJhpmt5Ntp2r6LC5zZ1GPxZbk3kFHf7X6uHBlPJS+07sDGDH3CV52tWtUaYKqZ0tz6fE+rCmNtjdv2eY6cYBQv4s7rlMdMYhGb2mFgt+cD3FQvtbWqSOYvHYDqmS9ZcTgJOXK+gCIoaHMJ9XlMnu99alRydh7OSiXGafbHcq09J45mIn04CpNY+PVJGV2jpVGUqbTSnNRYW76/JtXKbjo2aNSqmcJjrGK97VebVla1fvjpGiMuGFi/jdSw+jXGykDtV82m5KNVGLrjlA9TbRnC6LQjNMhlHGVho/h0h/tJ1Bxy+la6dSyrKkmTZHK3cTtLBHnI0sqF49wgW4xQfK9LQEUO0aR9JFZcPdoVqiv62rxLLhiw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ac4d49-4354-48a1-4f2f-08d85ab61372
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 03:02:12.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoGsB3Pm0kKOPGE0fHK/QQpUxQY51hwgyubqPSBftW2Nyfz1T3EWPF4XjzqN3iHp/4XBPOzwVLIbsuAzpIsd+cCAUc6iKCIdNb0zMIu8GIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3397
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FfW9bueMLXZHHZqtrz8mpc5sx4520388AA=
Content-Type: multipart/mixed; boundary="UIqcsOeDXRDoYQrRrz89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600311741;
 bh=Wiicj1O5AKu+IOhPU20RnfiZABc/NqqkC5QDibX9k00=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=okunVZedLwu7d0V47gHUHNYkk/kIiNlXw3ElThEWP5ctDVQWjfGSUTqacYYhcKQ2W0I
 HbHXCUiaiiSOW2600ioQ5zn2LjJu/BZ8Q36xgEcqoKN0lo2K5FhK0k5LnF7ZqDr0IAXcz
 t6cWZMIEGDuvRA6HJbHdZwXuhUe6A6d3LjA=

--UIqcsOeDXRDoYQrRrz89
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Venkata-san

Please check my inline comments and send me a merge request when you solve =
them.

> -----Original Message-----
> From: venkata.pyla@toshiba-tsip.com <venkata.pyla@toshiba-tsip.com>
> Sent: Tuesday, September 15, 2020 11:24 PM
> To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#=
C"~#A#C#T=1B(B) <daniel.sangorrin@toshiba.co.jp>
> Cc: pyla venkata(=1B$B#T#S#I#P=1B(B) <Venkata.Pyla@toshiba-tsip.com>; cip=
-dev@lists.cip-project.org
> Subject: [cip-core:deby 2/3] security-configuration: apply security polci=
es using package bbappend
>=20
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>=20
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
>  .../recipes-debian/pam/libpam_debian.bbappend | 39 +++++++++++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 meta-cip-security/recipes-debian/audit/audit_debian.b=
bappend
>  create mode 100644 meta-cip-security/recipes-debian/base-files/base-file=
s_debian.bbappend
>  create mode 100644 meta-cip-security/recipes-debian/openssh/openssh_debi=
an.bbappend
>  create mode 100644 meta-cip-security/recipes-debian/pam/libpam_debian.bb=
append

Ideally, you would separate the patches for each file unless they have some=
thing in common.
=20
> diff --git a/meta-cip-security/recipes-debian/audit/audit_debian.bbappend=
 b/meta-cip-security/recipes-
> debian/audit/audit_debian.bbappend
> new file mode 100644
> index 0000000..c148f27
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/audit/audit_debian.bbappend
> @@ -0,0 +1,20 @@
> +#
> +# CIP Security, tiny profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# SPDX-License-Identifier: MIT
> +#
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
> +	sed -i 's/admin_space_left_action =3D .*/admin_space_left_action =3D SY=
SLOG/' $AUDIT_CONF_FILE

Don't you need to specify the values for space_left and admin_space_left?
Perhaps these variables should be configurable  and have a default value.
Example:
AUDIT_SPACE_LEFT ?=3D "100"

Then you can change the value in local.conf (or using kas's local_conf_head=
ers)

> +
> +	# CR2.10: Response to audit processing failures
> +	sed -i 's/disk_error_action =3D .*/disk_error_action =3D SYSLOG/' $AUDI=
T_CONF_FILE
> +}

Please check if you need other options as well here:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/ht=
ml/security_guide/sec-configuring_the_audit_service

> diff --git a/meta-cip-security/recipes-debian/base-files/base-files_debia=
n.bbappend b/meta-cip-security/recipes-debian/base-
> files/base-files_debian.bbappend
> new file mode 100644
> index 0000000..895dc9f
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/base-files/base-files_debian.bbapp=
end
> @@ -0,0 +1,3 @@
> +do_install_append() {
> +	echo "${MACHINE}" > ${D}${sysconfdir}/hostname
> +}

Is this related to the security layer?
If not, please separate it into a different patch and explain why it is nec=
essary.

> diff --git a/meta-cip-security/recipes-debian/openssh/openssh_debian.bbap=
pend b/meta-cip-security/recipes-
> debian/openssh/openssh_debian.bbappend
> new file mode 100644
> index 0000000..ddd2bfc
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend
> @@ -0,0 +1,19 @@
> +#
> +# CIP Security, tiny profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# SPDX-License-Identifier: MIT
> +#
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
> diff --git a/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend =
b/meta-cip-security/recipes-
> debian/pam/libpam_debian.bbappend
> new file mode 100644
> index 0000000..c9c1605
> --- /dev/null
> +++ b/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend
> @@ -0,0 +1,39 @@
> +#
> +# CIP Security, tiny profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +#
> +# SPDX-License-Identifier: MIT
> +#
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
> +	echo "* hard maxlogins 2" >> ${LIMITS_CONFIG}
> +}

Thanks,
Daniel

--UIqcsOeDXRDoYQrRrz89
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5457): https://lists.cip-project.org/g/cip-dev/message=
/5457
Mute This Topic: https://lists.cip-project.org/mt/76865928/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UIqcsOeDXRDoYQrRrz89--
