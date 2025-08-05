Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C41C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 01:16:38 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.web11.6833.1754418707804360029
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 11:31:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NeZqa0Ob;
 spf=pass (domain: siemens.com, ip: 52.101.69.14, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUpnXUfT6eeengex2M56Ml0UdihIb1zBlVE1easZpGcjvDt2hdDRr/vOHyz79xIHUtQjo2mj0gmTkrlDo8RO/8XLxrmHxxbSKwOvXt0aCdTnAEMEuZLptA/kaagXs8DnpkBmeEnjnWY7PhrLf4XzTRBBpB3YF5i7FEb9rVp71vHqQkv1dOAH4BbElvt47HT40FB/UY2n5hYG0ZCbJrMXsUl+3TuyyiKXoZ1GHVbPHXkpF4Pf4VcrSIB67rErjnCPjROYfUwJ9VkoTliVFr5AzpbigEUSz+p/21lfqZTQ9nAILjHIBnpFDsdrqljmSWFy6dLAeczjmHzpXbeXiwDSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJKzY0iuDqous7dcv+vNng6Vm7c4jzzcHVlNHjLHOEc=;
 b=aYZFlxqI4+W6C+4egius75cpH2ltUn+x/xL/aJnZr44rNp7bO481cdAkaPDV2GfvDOr345DbVNWYe8EaYBuxGz2WeXfVg+88jZe4UR4as6aM3PEpGViUYsgbF+FTjRq5cyAgeRO21RLGAK1+X9IVANmg0VH0QKOE51kHZzNA9/Qmq5NboPxjmk5xD0ZAI4mmf77tjWxwR3gBDkXAMq2nmFhqLKQh7Jx6jnAT56y7fskyNTUys2C5OaOJwQTW55G6vXT1j8zXxyJTZGxebI86wV5inKDrgokm+j7J+Dd9+b8a3fBSEXzROLAUHuZ+O//zYLx9Uk02sX5W9ovtixWAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJKzY0iuDqous7dcv+vNng6Vm7c4jzzcHVlNHjLHOEc=;
 b=NeZqa0Ob81gZEJschJJBFMov15qxzOFsWuQr8/oAXIMBvgqjHtLuTx1ojdlPxiW04I0Qb0Q35CEp+R+tvb6rpgNTpbEqXG1+cqLO4flvd/TQv+TMCETf2FVhTzNaZLozFje+PYQtsiUEHowPdqZ2+AGANW9B/QTKdq4PXMKNK7goClKO/guNdKdQwpRf39zEbtZe8UsU1i+z9k9ZOAz+ekA23c6IqN6ttf+Uex5hdWSz8nZXXPGfkaVe47tWJBQaVcY2uzi89HKyCfzTRoMIe3W2DhBptd9IgzPnUql2LHnuKgc3l6hNzP8HleiFVZsxm27hov/KTMDUxpAZM/Rgfw==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by AS2PR10MB7347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 18:15:56 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:15:55 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/7] add factory-reset-helper to set the marker file
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 1/7] add factory-reset-helper
 to set the marker file
Thread-Index: AQHcAhLnISmgJwBF30SosHU9uK6nZbRUYFjA
Date: Tue, 5 Aug 2025 18:15:55 +0000
Message-ID: 
 <PRAPR10MB54225CBF1FE9452C812D29F88022A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
 <20250731120043.333345-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250731120043.333345-2-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=9f85c810-f608-46ed-bb6a-4d6c95f2d14f;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-08-05T17:56:19Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|AS2PR10MB7347:EE_
x-ms-office365-filtering-correlation-id: 0367f878-629f-4301-bb66-08ddd44c1ef2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?ebUJY7cEQt2dK1v0inSvOnPrHp5ssgOdogz8J8ALlIeNvyGIs6qC1e4bqu?=
 =?iso-8859-1?Q?AzRwSaiTqMLrZexWbSEXX5fawiLCFWWqubKiPZpoKWcSx5ArKs3+iPyoGg?=
 =?iso-8859-1?Q?jUr72E/MfC6ze5qZB5udC8ZvL6Pzho5RRWvw7oNbIQBwqlkK7A1kNwn7MM?=
 =?iso-8859-1?Q?rIESDWaeaKQ1nuFV14jcTvc1kzNFwbavqDsKF76K39zJBzB2ouYHaU4IAu?=
 =?iso-8859-1?Q?fXvHZye27ouNGVHEcrZ11a6Z34Fk+zwzxrOJOjqdWDIKEQwlFL5bSh+XYI?=
 =?iso-8859-1?Q?Ai1+nKS1bJ9SCrgahZH0eTfcTBQQRcBGq/SROM026tio0CQdAIkoZ1Sfad?=
 =?iso-8859-1?Q?pZGa83i4SIUEgOe+IRag7qIDqgN+JI2ymZt3IRegDyayxXSoGzqzJcfTws?=
 =?iso-8859-1?Q?ycqlMF5hC99MkcUofaZbvp28+T3xkVmVP4j0hIobxsZUYWn90SpWiUQCvX?=
 =?iso-8859-1?Q?aT8W0P91yfIG9htXRGDb4Z2b8lyAE8gHGek9K7+R6Tk22gWfn8QhHWOMrG?=
 =?iso-8859-1?Q?AHzOYwEj/eRFU7F6V5hnCT1Bhs52lkxmafuP91mBMM3Pw8pl8Q0P0jNVEV?=
 =?iso-8859-1?Q?ZD3ym3+LWLSx7rKLAgpXXFJQ3FqOy/BJ3kQ5RtZ8552/VXoai8caj3+WN8?=
 =?iso-8859-1?Q?t2wwhN8XT4FgrvB4frTqMpUtKcbXgS7lbZDdFPsz/N0pAfQgoBs20YV/d1?=
 =?iso-8859-1?Q?cAh/XG50jRMzSpN3067HMdV7Y43WjCjowROx0Lg/1cqc7Xi64VzNn1GoSS?=
 =?iso-8859-1?Q?KbwqaWk6AqJ97IPY4cgcUFzRppmYLzvRuRtr9cTPOs5J6vOuvWMW08bsFZ?=
 =?iso-8859-1?Q?Nte7wkD9pnyl9lEwCrXMpHyy3RMBbOvIcMo3XMFkQAXAiHGmMjJ2afQK0i?=
 =?iso-8859-1?Q?l/TQeBraG6XJvREnId0CQInqyBTaU8UsLd5X1YjadMAE2LhD0QBi1cmATQ?=
 =?iso-8859-1?Q?ZhuC76lw4da3SNP8RNnwL/hWdUvMmiMVDkZzrYa0DRxilCXBDhthf55ySP?=
 =?iso-8859-1?Q?LU9qPY8pWHjyKxOheTTYnjQGI1O4ZjFKpiXCn/xTyz6Wz3HFjp9q8q/MDc?=
 =?iso-8859-1?Q?mm/XHQ6+hKkSJTykYonLcjB2TA3HznF4RFNvOjJ2lENlmXEO5v9mwps+c/?=
 =?iso-8859-1?Q?ulOt99EWQCyRIx/cboC/hFFqeRgnO+edysIm0Zd/V1n+/j052e4O+22Ej9?=
 =?iso-8859-1?Q?cmCbZLpeRp5sRuath82iO1dBVJ1qsU92HvaUTzmMpzmy9aQvmi4uYKk+Wg?=
 =?iso-8859-1?Q?XKiZn4VkEDa8SHk9C/iZUBwKps/nFsi8ZN+Gm1uBk+2z94OI8AifRFc/Nn?=
 =?iso-8859-1?Q?NkjkecnP2dt+kpyG8HaEdph+FGIypRhO8jYJLgPcdMuv5gXhZqQKPvcIWC?=
 =?iso-8859-1?Q?nQwQ/iazAUEQSYlwZ8CDrs6BQ4UjECO5pamzt5J9IrgfazDvFNQQIuAIiw?=
 =?iso-8859-1?Q?k7TX5AgbaXulQaFK9uHZjKslKpN4X0Kd9ZW3tq9kI6lNdsl5CaIoOsadad?=
 =?iso-8859-1?Q?wYBLIqrAg6XaDPNOlFhAVKS+CGKr8vgNgAGxYGCmNEBw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?PIQId2vybbf+maCSEBp/kDyadMFK/NGvw9YqztegmsXWrh5wNNmJ5Y2YpV?=
 =?iso-8859-1?Q?OXwHeI3PVoq4y/jL/xi+3yS17HMEiLAt1ofHmTZwJxJPx79MiLxBTkWAVX?=
 =?iso-8859-1?Q?IUXeASME+YNRUkOeitS+Ae1jK3528bkYIGj5r/Ve6qIYOsDIiSyG+KXlz7?=
 =?iso-8859-1?Q?hmMN77yb7bk+LBZYRXxU1QE98cSR3XfEZsw3rYus+/CyVNBEcEtyjdR+TO?=
 =?iso-8859-1?Q?8XRtJEgH5+VsP+1541kNaex091OHdYP6w+d4BBVRt9C2XFpbXFRSZAKwfH?=
 =?iso-8859-1?Q?uz0x4o9K6CKsXQRAxk+UmaptuI4Ys4cUACnWV7Sr2OUceXvae8kfxnHuvl?=
 =?iso-8859-1?Q?R7UT80kqQTSWTzqj5qTsQ7Ba4yqeTPzfSoN8QNIcS33EOArhfSkNA2/I0J?=
 =?iso-8859-1?Q?KP4Qzlg1Dt5dihXuUoZPt/JWokaSNGR6BH2BIs2yxLX5zpPbeom7RqPh6r?=
 =?iso-8859-1?Q?Qq3+Q+DpTtMNbxbQMcYSCQLYSHxTwcnewcGgloRnYXPlT0gsw/BopOqOtt?=
 =?iso-8859-1?Q?y3xgFlrZHUDJg4UxAY5amTrHwqQnaKuwEhFQ2UPKmGD7xewVOo0y92H20p?=
 =?iso-8859-1?Q?fnbiok4hY8FvUuZnnfOukSVDUckhDmbBV2dB4BLN0X8tERGyQTq3N2gTAM?=
 =?iso-8859-1?Q?RZtuHaztZ0pCBmkqIWUYhidPRwW9wXUjjUr83T8hj2fobttk+EMTYcs5HB?=
 =?iso-8859-1?Q?xJNKSFb62YaChPlyE9TmYbHClHB59mQ0+XLgR69iw0NPrLbsZ55plDRjqh?=
 =?iso-8859-1?Q?3c3OhVLsK46740wIBaqVcjFKPALdDdOgce95E16+8kJ1y22Ysch8iNgQQf?=
 =?iso-8859-1?Q?6wUtByvgY+lmfpA6if3aQc8X1RnOKZ0ID2E19h3+WOAGAHQVh/BhK1P3QH?=
 =?iso-8859-1?Q?r+nHuQPm5i3z2AKKa0tayndCavtT90DPhmpfAByqKyPjMiDQ6cGrNTPrmS?=
 =?iso-8859-1?Q?mHHjU3pjxz8oJTSUmy4e2fbzVgNGgxyNbn9SSVBYd1i1XKVJOdPOyecn1q?=
 =?iso-8859-1?Q?2Lta6ubD2WuEZLxg72pHjX8KxJGFy/drQPVmpSA7a3f4nT+/yrFMqeUb2N?=
 =?iso-8859-1?Q?8tKbKqdu5uSTerL8U92VfR/GPQLPUs/onxWyDWSVRfVBMuZsIfwVB3SQw4?=
 =?iso-8859-1?Q?5aau412slxMo2muM5uPo2VtWqrhgkYGhRz4rKHF/2+n8bKv/Il6hlaiCXL?=
 =?iso-8859-1?Q?pCJwKeeNy1EzAffKL3t0TkYfMAEYCufEGFo4TfF/PQMNTiHO1rMM8g3l5o?=
 =?iso-8859-1?Q?fOHQF3VnwKTVkmRhhAyCUAmA+nLRpbIfQGc6pMPNPNLqJgX38qPQA1XiPp?=
 =?iso-8859-1?Q?WUm9bEM1PVKaScW+AVAhYNoWO/kafuVo6ToOJzMTWB8bR7t9RhIzsvgtj8?=
 =?iso-8859-1?Q?+rfvGofbhDluNHbp8UZZ1ax0KPhryE3x1itSL3DB9Qx6xBf4vnSZ7ubAul?=
 =?iso-8859-1?Q?L4D0d17fzjdNxgfpKD5GEqnoe5JpEHFSDMxzZG7/7lQbKDXrLc7smXdDUv?=
 =?iso-8859-1?Q?u924Nozt9KnrRvSi/2rL3hfYDYHy0ISPskrcfUF94GdMhtJ6aKUhHfyYB9?=
 =?iso-8859-1?Q?AJ544I3MGTek59hcO3PKgrN2jlsodENKUlGDARJFlqhhe4DOuOOmMwahWG?=
 =?iso-8859-1?Q?oEVSfS/I/B4xe45l/i+W93k+OaKNlYc0SX?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0367f878-629f-4301-bb66-08ddd44c1ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 18:15:55.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyzXAKfaHXcNZzf0U8plgiGDdkQZ96RI1Wo4BKmE9NeSlQ7Of3xUOcfj/h/MbSOOttdo/EJRCv0aEpC/Hc37uL+9AifYOKKBS9GATkHv6UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7347
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 01:16:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19675

> diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset=
-file.sh.tmpl
> b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tm=
pl
> new file mode 100644
> index 0000000..639167e
> --- /dev/null
> +++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.
> +++ sh.tmpl
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com> # #
> +SPDX-License-Identifier: MIT
> +
> +marker=3D"$(basename ${FACTORY_RESET_MARKER})"
> +marker_storage_device=3D"${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
> +storage_mnt=3D"$(findmnt findmnt  --first-only --output TARGET --noheadi=
ngs "${marker_storage_device}")"

This needs to be fixed: storage_mnt=3D"$(findmnt --first-only --output TARG=
ET --noheadings "${marker_storage_device}")"

Additionally, I haven't looked into the reason yet, but when running on cip=
-core-image without any option,
no link is populated into /dev/disk/by-partlabel, so this might not be usab=
le with base image target.

    "special device /dev/disk/by-partlabel/efi does not exist."
    root@demo:~# ls -la /dev/disk
    total 0
    drwxr-xr-x  6 root root   120 Aug  5 17:40 .
    drwxr-xr-x 15 root root 13660 Aug  5 17:40 ..
    drwxr-xr-x  2 root root   220 Aug  5 17:40 by-diskseq
    drwxr-xr-x  2 root root    60 Aug  5 17:40 by-id
    drwxr-xr-x  2 root root    80 Aug  5 17:40 by-path
    drwxr-xr-x  2 root root    60 Aug  5 17:40 by-uuid

> +tmp_mount=3D$(mktemp -d)
> +# check for marker
> +if [ -z "${storage_mnt}" ]; then
> +	while true; do
> +	    sleep 1
> +	    if [ -n "$(blkid --output value --match-tag TYPE
> "${marker_storage_device}")" ]; then
> +		break
> +	    fi
> +	    time_elapsed=3D"$(time_elapsed)"
> +	    if [ "${time_elapsed}" -ge 30 ]; then

Results with:
    /usr/sbin/get-factory-reset.sh: 23: time_elapsed: not found
    /usr/sbin/get-factory-reset.sh: 24: [: Illegal number:


> +		log_end_msg 0
> +		break
> +	    fi
> +	done
> +	if ! mount -t "$(blkid --output value --match-tag TYPE
> "${marker_storage_device}")" \
> +		 "${marker_storage_device}" \
> +		 "${tmp_mount}"; then
> +		panic "Can't mount ${marker_storage_device}!"

"panic" and "log_msg_end" are not usable at runtime.

> +	fi
> +	storage_mnt=3D"$tmp_mount"
> +fi
> +if [ -e "${storage_mnt}/${marker}" ]; then
> +	echo "factory-reset was triggered"
> +	# delete marker
> +	rm "${storage_mnt}/${marker}"
> +fi
> +if mountpoint -q "$tmp_mount"; then
> +	umount "$tmp_mount"
> +fi
> +rmdir "$tmp_mount"
> +

Thanks,
Gokhan


