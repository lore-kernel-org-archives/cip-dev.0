Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C516EE4996
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 06:54:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.2892.1692687294136808917
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 23:54:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37M6spNH1710333; Tue, 22 Aug 2023 15:54:51 +0900
X-Iguazu-Qid: 2rWh7t7B1r2FmC8D2Q
X-Iguazu-QSIG: v=2; s=0; t=1692687291; q=2rWh7t7B1r2FmC8D2Q; m=2xNE3EQJkGyvJQWJn3JAXP4K38qlueYYGBWwc/v/WVc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 37M6snwZ209682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Aug 2023 15:54:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVI1BY/hH5yDgFjaJkJVds+XIC633YnHkD0qPOqGEi/BjWtRcEFI9IodyMywgui70KKQGNuuyOehEcPKCaUr1azQhb1Hbklzh0xk/v8NZ1sz9ErfLW0DbzdFMKvEaqKbuKiKxzyDPUEl8AUeVVg+c4Y6OD313qcQS+nRkDIOI4nsVoZxhcL11yFtoG/OgCp6gozZ5xWjkSunWq6tRqtpAuL+XrePtbRUXCI9eAkh2nUkyy3FNb2TQGhVXV07Xfiu1VkhpUM355BJjYcTslKQeEHcEUnld/gk5XvJPqZA8Sjpw4rbLmXOD5/TcVWXh0+ZmtrV4U5ytWFAmSVccNiyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn9HNC7/ykC1gSKEV/WepfTL+csPR7QcUnjP3iYhLuI=;
 b=dPnF0hn6DWmrTe7LNicSycEdjbSj4U9fHNu8Sx2oWyk/CqY7XrBbFj1Ksp/9COISpoRzMiaghYvaSjt81GMcpq3BidBclqmbWnVl5RvsXwLtBvAbNedgLVOWEuZRbJT/gdMHNQz6KDFAlh8UEJ7otTrk/kiv3FifmVnc7ObH7EoC8p5whUAQmI50zvQY+U6nD3uPIxGSGIXifHtqNaiq+wI7DAkB1agoG+2w4I5X9ZnmRT0c1v6FDZBTmLngzU/V8wUtkZItAorLYMoKojppx99j3WGJfwb2sLb2L43Qy43WBBrRErACefNYeWl1rwCPNZ7hqsNULrV7SJCxOL8JKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <tho1.nguyendat@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <tho1.nguyendat@toshiba.co.jp>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core 3/3] Enable secured boot for BBB
Thread-Topic: [cip-dev] [isar-cip-core 3/3] Enable secured boot for BBB
Thread-Index: AQHZ1MUf4YOmmFxjs0uZbMwAx9pZXQ==
Date: Tue, 22 Aug 2023 06:54:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB5880D01E2FB9699B6F47A66F951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Accept-Language: vi-VN, en-US
Content-Language: vi-VN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5880:EE_|TYCPR01MB5773:EE_
x-ms-office365-filtering-correlation-id: c67ff23c-b1b2-4bb0-83bd-08dba2dcace6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BwnSuYGPuR/7SttX8i8l1CsCK9x18m5IRhzN6CXOeB8xhwxM2eGUYpfcdJJga+CmNVbwUR/EBK3j8Fv8SCXZwG44oYiiSgpTCVA4r7AGbiIahtPJV+WF82YNM+RPUwZFCAk4RUD+tdvJmn+zj9XmH8o9J/TCtAClcs+dO2DuJVwZqqdotaPdcyvSOqVTsJqmiicSXB9oSPLEnSDc7F7e9tjmz73Li+IWMbhkvbvsF6l3DyCvPx7UDdl3tyJ9oOL7MqdcHbVcxfBtq3N2ec6xrl8S/h3CST4+yE2A34zchTgof5TtqcBZrVGUi2Dw78Met6EfQvmns+JV5wFYRLmgEyrVWeq5QgtjLaoPF9+o4j0objunGz76TgHGT3Z/YIUo6CqQXyYUNiaYWB6zp1f3DtLAMTOOuKnFzcjuObDZwpofG3m7+HIYTeGnOvn8vcrttNkPun1/5wUadFhClplyVqwQhEwtyofxVkouAvIhdfx1mjvo+aX175tXG7WBt8wkv2/CJJfXlNSpckL6LQaOUo9DEI0TU7uLv4toY0ATQyDgZBwS3H1z5pcUXZ4+aTTnDH2na2uIEO2rvmY+v3d1GxgTgTXApVknP286SmpZVArb9UxZAE3KOvZqf5h+7Ehu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5880.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(1800799009)(451199024)(186009)(71200400001)(4326008)(8676002)(8936002)(316002)(478600001)(19627405001)(66556008)(66446008)(110136005)(91956017)(54906003)(64756008)(66476007)(76116006)(66946007)(41300700001)(7696005)(6506007)(55016003)(9686003)(38070700005)(122000001)(38100700002)(33656002)(26005)(53546011)(5660300002)(107886003)(2906002)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N1hyazRZaGNXS0dQMTAxN0tFR1dxOU1JZk9YMTJzeUhEbmNRQTZoQkty?=
 =?iso-2022-jp?B?azB1bFNMMXRlVHd6Uk5XUjRSbnlmb3MrSWlLY285WFprKzBLWGdNN2Z6?=
 =?iso-2022-jp?B?b1o2d1JxT0gzei9EeWgrem1JcjgvdlpLZG1Od0kwSHdobDYyUFBTOHZZ?=
 =?iso-2022-jp?B?dTRIenBpVGwxMkJxOXN2akxKUFV6UlUvTmdMTkZlVk1IbWdLWVM1RDgz?=
 =?iso-2022-jp?B?VWQ2QjB3Z21BN1o3VTZJMVhyVnMvd1dhZFVSenlPRnBQN0JRS3BNMHVz?=
 =?iso-2022-jp?B?OTFPdHZJK0NVYlk1OHovdmdzWkJPc2c5S1E2THBRbGp4RzBVMi9XcktQ?=
 =?iso-2022-jp?B?T3YwNzMzNGZVYU0xdERmVnRzQzF0ZHVKdnhDWDhQSGs4YWpGMHdMMTlx?=
 =?iso-2022-jp?B?cjdnVzNmKzF3S0VVTEpKNHEwbi9zbzR5dDVHSmpNQUVDa3JxNWhFRTUy?=
 =?iso-2022-jp?B?MlpnZnp6eWRsVzJKS1JTcG9LaGp6RlNnKzlRZ3lUb3dXOW9oOGRNd3Zj?=
 =?iso-2022-jp?B?cDIreXZuamRyZzQrVHZjazV0RUIxYTE0SGlIclJKN1JENVZoNFF5NDJV?=
 =?iso-2022-jp?B?MHhPdjh4M0kyZEhKaWM4bEtTQUFmbnpWRDcxaGhwMm9GcmpaVVlEWmhJ?=
 =?iso-2022-jp?B?c3lrOXMvNUdlejFFUDBxNnVHRWNCS0VEOEhlU1o1aVZTSXJ2dFYraHow?=
 =?iso-2022-jp?B?YjdwWjQ0ZlROd3NWK2hXY0gwR09RM2x1WTRhN0ZHSkExSllLSGNYRTZT?=
 =?iso-2022-jp?B?UXZuSHZXdEtQMzVCdHlRSkg5emcyOTF6L0xJb3RvOGVuQVdNRmRLMC92?=
 =?iso-2022-jp?B?aHVOOFpoSXVjUFA3bTdQNnU4VVZQQnEvRFByMGh0eTZUUXVEc3FKY3hN?=
 =?iso-2022-jp?B?YjBNTzc0Z2c3SEcrZGpleU95aTBJMWp4NjBSclhFbW9PVFlaaS9lYUg0?=
 =?iso-2022-jp?B?VFQwMFlsZTFudVFUTElYZ09jc05kZUFCdjNrREU3NkJZQVBQSFh3ZU1i?=
 =?iso-2022-jp?B?YjVOZ21xZFJnK2FnM1orY0g4RTdremRLL3B0MlNKajZ0bDlYZlJDdG9D?=
 =?iso-2022-jp?B?U2l4T2NJYVJ4NXpIUVl4OU5mRjVIdEk3K0NYT2l2aXJzM3duVnNNbmhZ?=
 =?iso-2022-jp?B?T2lHT29wREVIeXVWQmU1UkhKNWsxU0FldXhvcDRhNCsyT3FwSDc0Q0h5?=
 =?iso-2022-jp?B?RWY2MUsyRHhWYUdkSWJzejhrcXhXWWdrblg0UFNWYUNMWU9XdmZuYmNn?=
 =?iso-2022-jp?B?MThkUkJoWS9lWGwxQytSNVdZYnY2RFFSY1htVDI4a0JPaHhXaWlJZ3Rw?=
 =?iso-2022-jp?B?aUV5ZVA0eTFwSiswaHJYUW5pbGk2dmFPV29Gbm5MdXEyanQxU3lodEEv?=
 =?iso-2022-jp?B?M2V3QkVtRzZ1OGVsMjlEaitkTFdVbUkwdms4MFFWazNSOStaY0tHb09T?=
 =?iso-2022-jp?B?L2lzZ0RaRXVZVTlaUFhJMExaTEZjR2ZNcFkyeHVIRjFjL1RlWTRlclRk?=
 =?iso-2022-jp?B?NTVvR3I2L2l5R1EwbjE0eFhva0hIWEl6c3FaV1l4T290Q2ZZVndqb1No?=
 =?iso-2022-jp?B?VFZFdnI2bjBjVHgydFY0SDhkQVQ5YmJ5MEtXWW5aMEpaSzNaN29pSXEv?=
 =?iso-2022-jp?B?VTRweVpISkM1YVNlSnB0VEZTdllTdEpOSm13VEJHMURQek1VYjhURlMz?=
 =?iso-2022-jp?B?aFhiRDJBT0hPL0ZmemdYMnV4T0h3QytHTXQ3SGRtTy9DamlJUmZVZ2Fs?=
 =?iso-2022-jp?B?NnJzSGY3WFVaSklyenV1Y1FLS2g5K2NoZHkxd2pxZVErSkw1MDFTcVpX?=
 =?iso-2022-jp?B?dzFJREI1dFByNWZYWnkrakdNWlVXbjJWTXFyZmZjMnhaamNZN2Z2dzZY?=
 =?iso-2022-jp?B?ZEh4ODhEUDV1OVFuR1RUMDhuaHc0TkduYUlPRWc5VVg1MW43Kzd5ZFRm?=
 =?iso-2022-jp?B?aVZ4Rys0Ri9CNzNmZk1xWVYyQWNRRXhzK3Fld09XZ3ljclVyeVRTY1gv?=
 =?iso-2022-jp?B?UncxQnZ0WUFaZGEvMEJNbll1aHdSbmYzR2duZG81UzZ6V0srdHA0cVdI?=
 =?iso-2022-jp?B?NlM1blVQRXozczdmRjRLdFE1ZXRma2Z3ZmhBQXhvMnBJSEc3K0tKTHk5?=
 =?iso-2022-jp?B?T0lQQ0dRcE95VEF5UGxNQTRQUHhTcTk2NktTUlBxTWxzeE4rVDFJUWhK?=
 =?iso-2022-jp?B?ZlI0dS9LYVI3V3lsK2NKNnZCaTdQWEluUDRMK3lxbnI3aGtGZHNmS1Na?=
 =?iso-2022-jp?B?MFNUZnVlUkt4cUwra1NxUVZWYk1aTi8vUFJTN3dRcmNwU21YRTdQTUJ5?=
 =?iso-2022-jp?B?L0JEMFA3V3RRZWluZkxQcE1CSGpCQ0tQQ2c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB5880D01E2FB9699B6F47A66F951FAOS3PR01MB5880jpnp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0nLNrKTPk/mBiUrr9bWeulP/ZIB7lLtTymZaSRu/h7CWGt5QMI37dVscqWFlMXTuWNa1cA9CB/3r+VEAk/ispnvve1A+CW8A3OBbnzQTW2tIe4eniShp86EIOagwH5hBegoRcvoXhTqB1XtfUO+lnKfZHsKC0eNoYMljgW1CZje0H2pMY9KoDfE4oL6P6gM3WeHIpWRg+xCY//HfJYTTZLpmv2jpX5raMiau7Eiof9tkpEJyD8ayJG+kfwiUYuY1f9ubPLLawLRjFDGPj9O910F8gA2mJcM6ed+iqaTh0KAZmN1Jct/93zPSPLXIVgqz34bPSh+YYOf6tNfe88y26+18QKddLZ2gB0GbMX5U59hIdjod0kq+tcomisZWwTzw1ZH9PREtaUj6n//VbY31tpvmaZFKyv3NIMjiHBIHTrfgOyRCOJYXdwkXL01Z8tNpvfl8X9Rc4rkzJUqWTX1wfnTUaLjAK3pObKO611S3A3/GvXTiCJhWeeHIVj6zJv8yjyav99uvBfkUVKehby3BuSgj1oPUcjnipr7FQBOneBXXfWn1jw/k88ZD7dSLTDJBqyMDaEzUtfBhq2P6k1RI0RqpzvmVhfDIw/UeyiX+JR1g2hNRF8aMLJKl7U4fWJwJicQcvcTLbpFG4dVUO+fXhGlqkabvcvsvRrSG+inmcNlCnrsfGNrPWh7Mqz2/FmnR3b4ZUcArSIW6T2LUOKQSNHmtZp2btVFNLwf9F6wDoRnPAY5aa3KKT05Fco+xltQ/uV1tOdxPSBtAgZ56nh9PeklMz/sNOqxmgpWhD8YcnbDwgQ99VG/7EwxwdfoeuRxjWcQuUOytdWGAXJJa7q4aFA==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5880.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67ff23c-b1b2-4bb0-83bd-08dba2dcace6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 06:54:48.0012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03nRKrSqZ8qgtmZvtNZ28E+d1JzOcF2vQVCUQ7XDzqXGn+jO7wO1ENbRi4ICAhx/ZAGrqxm3pjO/h28+gm4FLJHanWkHnZcw43WnCv4y1t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5773
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 06:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12814

--_000_OS3PR01MB5880D01E2FB9699B6F47A66F951FAOS3PR01MB5880jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
Date: Tue, 13 Dec 2022 10:14:04 +0700
Subject: [PATCH 3/3] u-boot: Add EFI secure boot dependency

CONFIG_EFI_SECURE_BOOT depends on CONFIG_FIT_SIGNATURE.
Enable CONFIG_FIT_SIGNATURE to make sure CONFIG_EFI_SECURE_BOOT enabled

Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
---
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 956dcbf..6111007 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -4,3 +4,4 @@ CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_EFI_VARIABLES_PRESEED=3Dy
 CONFIG_EFI_SECURE_BOOT=3Dy
+CONFIG_FIT_SIGNATURE=3Dy
--
2.30.2


--_000_OS3PR01MB5880D01E2FB9699B6F47A66F951FAOS3PR01MB5880jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">From: Nguyen Dat Tho &lt;tho1.nguyendat@toshiba.co.jp&gt;</span=
></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">Date: Tue, 13 Dec 2022 10:14:04 +0700</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">Subject: [PATCH 3/3] u-boot: Add EFI secure boot dependency</sp=
an></div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">CONFIG_EFI_SECURE_BOOT depends on CONFIG_FIT_SIGNATURE.</span><=
/div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">Enable CONFIG_FIT_SIGNATURE to make sure CONFIG_EFI_SECURE_BOOT=
 enabled</span></div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">Signed-off-by: Nguyen Dat Tho &lt;tho1.nguyendat@toshiba.co.jp&=
gt;</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">---</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 1 +</span=
></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;1 file changed, 1 insertion(+)</span></div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/re=
cipes-bsp/u-boot/files/secure-boot.cfg.tmpl</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">index 956dcbf..6111007 100644</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl</span></div=
>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl</span></div=
>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">@@ -4,3 +4,4 @@ CONFIG_USE_BOOTCOMMAND=3Dy</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;CONFIG_BOOTCOMMAND=3D&quot;setenv scan_dev_for_boot 'if t=
est -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi=
; then load ${devtype} ${devnum}:${distro_bootpart}
 ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${=
fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 10=
00; reset&quot;</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;CONFIG_EFI_VARIABLES_PRESEED=3Dy</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;CONFIG_EFI_SECURE_BOOT=3Dy</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">+CONFIG_FIT_SIGNATURE=3Dy</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">--
</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">2.30.2</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_OS3PR01MB5880D01E2FB9699B6F47A66F951FAOS3PR01MB5880jpnp_--


