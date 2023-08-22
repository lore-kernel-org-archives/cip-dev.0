Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5EEE49A8
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 06:54:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.2815.1692687266749724125
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 23:54:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37M6sPbR3159006; Tue, 22 Aug 2023 15:54:25 +0900
X-Iguazu-Qid: 2yAbS7mhe9sIV60yGr
X-Iguazu-QSIG: v=2; s=0; t=1692687265; q=2yAbS7mhe9sIV60yGr; m=ovH6pHa6VJnsa/lWYeE/065JizmjKCL+zbCASUFXX0k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 37M6sNxF2250740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Aug 2023 15:54:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSJ6RiHLwXHnFu/P3W3Y8COO+ewexr46IbBDzXZDiRbBlhU8CbMcPLT/P6Kg51o6neSJhnoQvbwfoh9QL5r+Z0s8AZPK6PP+LdZDbXBa0LDbMJbUFcEqNgknqSJHd5fafI5IJxNSA1zKk0Hij2G9R8CtcPniyHjtQcoHdjdkKVhjAbLq63GPv39YvmAi67D0Uw1jtVXrcO6htkI2oeLG5oRVgPSNKmxY7ej1b3VsjPnbhoqfPZIf8JzNxpe+QKX0DM/k1rlev0VuhiqGpZdXh3mn//evG1l+LGtHyrKvHsBNS/x3Eo9wyPhuVfoHpnQcXrMVeknU6a2oEcRXC/fHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYHzan7/rjcxB1BsBpSpFqo+cxMvHnVSf/PKcxL+f9M=;
 b=KGKxtdEMMASWoG4zEdFKJOVtyNVwLzi1IYtvDi0r3mmAvSpeNai5dagC5HPttg0ljtxTjKbJb2J21tjzGICQebqkKm3iulgnKWLy71vkZsqIZRk4bZAJa3Ol5Hv5jlb8rZ8IDwoPbyRs5d3wnttc0My1qzg1Cto7COtOFNphBTiq/YzeAIvmquT9j9DLV62kcfvYbjdBwanu7ABeMSiaNEfC6gm7pbR82aWaYPe+p1P1axou+Vk0UVbYmyU1a1E9hXbD9FI+R18OD7v6sxw/LL03hFsdqDjJVnfdyB6Zu5zAlvq6SiL7CQlSqQlBea9jURx5KUM5p6s9Q99TsKxRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <tho1.nguyendat@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <tho1.nguyendat@toshiba.co.jp>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core 1/3] Enable secured boot for BBB
Thread-Topic: [cip-dev] [isar-cip-core 1/3] Enable secured boot for BBB
Thread-Index: AQHZ1KR4Q2en6dCOukOqqLvV3XmYlg==
Date: Tue, 22 Aug 2023 06:54:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB58804858E28A74C02D594823951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Accept-Language: vi-VN, en-US
Content-Language: vi-VN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5880:EE_|TYCPR01MB5773:EE_
x-ms-office365-filtering-correlation-id: 2382ad91-c840-418a-0851-08dba2dc9cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zO3DTRTDDyVmLg16mNe4zFo4qtWOBjC92t8y92Pvl6YRuBhMvXgPTqY5eT5NW/+YZHx6YBjwoz2ZolUAwrE2D7vTor9RgL2aU3D0y7mo+8AR3beUcRTdK8JLCuxoaB9C7/U4LdvRfq4sVHNLMXqUNx98GYkbo6keimGxjBXXzZvuchxmpRoA7+IP1NqoewURRv+6URl/mXVE7QjjiQeEGWAgmNWdSbx8TrRlMw+jFwA5fOrNKn6Z7q/RHfFOAWW4NYswwmYfQAaM7NgsWArirnWzHAqh4IungoyOa0B9IN22DyNx+lNaYNpnfpscBtE0YspqI5jtuZOincAyGeY0yjh9W1vaMrejZVNLOKJ9/Cbyw46LoOhKDWlqY9RcxW86wBi2I8kK/2PJkN/2f5C1CN9QPw0H5/yRpw28Yr0hB+aUA+b/IpEt1aLQE8ZySOZkMdVJua6Iai6IcQlzXrrf/YWgenlmj9vLJ4QlElT4emmMDugKpApTVWHPHnhhz/N66NNhQ2uj3AKQrkNmInvwstHd1IZ05jcl+mbA1O1LV4NIwT6+o7dbbftp3LXh7UFJ7cK4n3iXZYO5ClEG0M62JNu30X9yfpviLU5CxysNGY9l2UTydrJYXvKISymbXtbv
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5880.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(1800799009)(451199024)(186009)(71200400001)(4326008)(8676002)(8936002)(316002)(478600001)(19627405001)(66556008)(66446008)(110136005)(91956017)(54906003)(64756008)(66476007)(76116006)(66946007)(41300700001)(7696005)(6506007)(55016003)(9686003)(38070700005)(122000001)(38100700002)(33656002)(26005)(4744005)(5660300002)(107886003)(2906002)(86362001)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QWRFb1FhdXVvRkZIRDJQUEZuL0ljQUVWSFhEUkFzQVUrdDhEbW81bVBh?=
 =?iso-2022-jp?B?alY2ekYvdjN1M0NBOUJVa3cxS3ZhbGNqcU9JcWhUQjVwbzJ3VjdKU2Nx?=
 =?iso-2022-jp?B?UHkwZ1dQWUQ5dk0vdGc4RG1XNC9rRjBiOUUzQnNkQ2hsUVB0V3RNdlB4?=
 =?iso-2022-jp?B?Y3hkL3I2czU2THpYSmxwY1Z4Tk5NSmNtMWtzVy9Rd241bGVhR041WXhm?=
 =?iso-2022-jp?B?Z1FCdnhmTW44SzJ1dHJSNzdpcU1Db1FqNmJJd0dCTmY5cFBLSEVYZmd4?=
 =?iso-2022-jp?B?dCtySkk3akIyN2U0Q1JkbEk0N2NyNUg3ZnpBdjg4WDJtZWE5R0tPOEhQ?=
 =?iso-2022-jp?B?VmswSHJOdy9VV2dBUEsrejVqN3ZzYU84RUNyNXZFOG11b25YQ3lmTi9Y?=
 =?iso-2022-jp?B?cjdNK0R6T2VOdEUwb0FnS3lQS3MwVGJzTVpaL29zem05RUpLMHhua1dh?=
 =?iso-2022-jp?B?Tk5pMElxd2FaSm9iVElzSUd5NHhSUWZCRVhHblREUDFHZ015K0JWVm9B?=
 =?iso-2022-jp?B?azZoVG92NTVQLzJIK3pYckYxM1FidmxYaUJBTjVDRkNFZTdFbVJ6QzR3?=
 =?iso-2022-jp?B?azhDbU4rNDFtK0pZTldpRnV1M0NMYk1aSWVOelR4anBvN2pIWW9FaERJ?=
 =?iso-2022-jp?B?WlVYK0pVaEVFKzY1RTVQbFd3OG9OZEIyQlhNVHdzK0NFTndYcWRGbDB1?=
 =?iso-2022-jp?B?Y3F2OVYvWnRPZUtDeWRtWHFNY2Q0MGpNWHVNdzVzRDFtTStmQkpZdEM2?=
 =?iso-2022-jp?B?b3RManF3bThKSTAzVTg0SG9rc2UyL0lqWWZSWDAvdzZidGZaeUJCaktj?=
 =?iso-2022-jp?B?dFkxRndiekFobEpYaVk4OTEva3ZTQThhcVJvOG9XSWFRS21iT2hlWWl2?=
 =?iso-2022-jp?B?OFVBL1lndllqNTdRK1pOczkxcjFQaEtYTUh3UmIyRUhhdnV0TTF2VEFx?=
 =?iso-2022-jp?B?NEkrMHNZaEdCRjRPRDdlbkdydjg4MWJQSkpQaTFGdnhqU2xuc0lMOUYw?=
 =?iso-2022-jp?B?ZU5oS0FPSUU4SGhNdUprQ0xBZmlzc0dPbHNsUWtCMThHUlRlS2M0YVVN?=
 =?iso-2022-jp?B?bnNrclBhVWd1QWRRRUdHM28xdGk3YVVyeEY3d2YzMXZFM09GZDU4c0JJ?=
 =?iso-2022-jp?B?NjFIN2h2S1d1R0RzTEpwaWZQblI4K29uTHY3c0d4L2gxZUNPU2p5dzlI?=
 =?iso-2022-jp?B?SG1JaUxRTWRZc05kWEFJczRjcHdENUNheWFlN3dDWlZLaUZWV2VnYlZF?=
 =?iso-2022-jp?B?K0R6bGtZbEZRVHdVZzJYQk1yUmNWazNTZHFjSEE4ZXFwZUdWd01HN3No?=
 =?iso-2022-jp?B?Lys2Y0c4UnB0UHNKZFlLbVRzVGdyVzdvb3crK1QwNGJrVjJETncxbmh6?=
 =?iso-2022-jp?B?UUpqZnJRdFJHN1hvSmNra2RydExuTVluSi9uTDMwRFpxMHVuQVVpajVG?=
 =?iso-2022-jp?B?UERTVURTYnJTTUNNd2lMeFZOMzRjZkZHVjNEVVBCZXAwR3NyRjE0RTlZ?=
 =?iso-2022-jp?B?bVhCL1dTeHFaL1hQa0lNT05Pa2tuOHBLalNVZVJ6MTFQdURoWXAzSHY0?=
 =?iso-2022-jp?B?dkxtTU8rSXhBSXhwc2lrRUEwQ3FVMFdyQzhLZXlQRDJJMHhkN1VrNXAw?=
 =?iso-2022-jp?B?T2h0c1lpeUZ5clFRRk9BZXFLaXdrZTRFc0szcFN5UUNxY280VVkvdTJ6?=
 =?iso-2022-jp?B?N3VUdVdGeFNvMEJSUzdmNytpakpqcGUwUFB0bDdzOVRHcCtJYWh1UWlT?=
 =?iso-2022-jp?B?OFNQcjRPeVRuaktyVjVNZWdGT1VpZCtxV1pydVMyY2VxVUlJVUp6aGY1?=
 =?iso-2022-jp?B?aERLci9EaGZ4cE91WmFEVjVwOVZwVGs1NWdNR1RzTmQ2aGdSTlRYY2px?=
 =?iso-2022-jp?B?VFhDTmFkdVE5ZkxTODk4L2JGNlN5Zis2eXVFbmwzWEVjY1lMako0c2c1?=
 =?iso-2022-jp?B?VkZVYjJrZ3pvbXArNnY1RE9UVVd1a0dNT2VkMlJtdTI4WVd2VmUyTWpr?=
 =?iso-2022-jp?B?VERPMitsU3VLTVMrT0dsWnROaWdIZVY5VlZRb3VLVUhVb1I1ZG1MSkNB?=
 =?iso-2022-jp?B?Uk5tcmpTZWhkOGNrbFdEU3Bvb3hmYW9zemZRMFpkQjh5WVZpWVZXTXJO?=
 =?iso-2022-jp?B?NGZKNk5obXJZYjI3a05MNnREYVJhRVp3a0tZSDBpSHppZlBqaGgzc0Zr?=
 =?iso-2022-jp?B?Qlc1NHY1clJTT2Y5RFVUNERVY3V1OWp4OGlvWVoxT1FyQ1BpanFRWU5p?=
 =?iso-2022-jp?B?Z2ZXRklHb05Wa2NxWDM5cS9YekR5MGdZNUxNbU9UZHpjbXRycGZMMVRZ?=
 =?iso-2022-jp?B?dGQyT0xvZ213RGJsR2pmRUpXb1RWRmxiVEE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB58804858E28A74C02D594823951FAOS3PR01MB5880jpnp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4qUjGxNisQTGn+kwBk5X+AW7oKuI5jPmUtDa6KVGIKsb5EKEtaN+BhZUGBC0dAPkwwNwHB4kU8rNENIjDQEB1a7XkDdoRUppCKJ/evZqlOvMqFhdz7Zixj+WgVQorhqJ6dFxaNFC4aeruz/h0ZTT2BMAHE0rX4bV3isWWl9MkzV+ScbJHrR4NOIG6R+J4Vrp00ixvHYgK7Z1JPfZv3IehLju8oF47z5OosH0juXUsaCssV763PMVJYd/Lrv1GhwbRmdlFqpJF3B2X+z7vaWgUsndtNlEceTkOiaFVFYGZvA6DRgXY4PKEXA9VURV2zqksApMJBOUVQ4zVPIuGFNAeq2a1ohtphy1Us9+wnDtwbKBc+K9F3DLhVxWHlqB2lfp7DE/KnjXzHFay5rWlxSsX9u6bJj+X5FwhxAUZxaNSY0qA54TVAIqSH4zhLA4X1ALfzlcqkLitNlX7XFPqt1cglDuju2exkofF6ZGB7AWYlRgKHjfUa68get52YfvyK3j5r4XiXXnEJE2eU/xUXeIbfSlo1VO90rR2VwAzmA9pDRi7riovkMHRavqW/ryY8Ncfnv/5QsBrDznG2/FZdlyhsc24H+dJ8FJFHroPdHn3qsZN0q1I6k7VceO2agKoRvEUDmXxIxad5EEQ5dtZ36pZwW5Ke0PdDA2Ck3p70bQjxz4sx66otV+7tmhV9UFqDgw1T3830hFTGMqTxC5TAMaWC8siFN9gtAOJY/X9qyr9T54iHDtyG20W4E7EG+ry6K/8M1KG8XT2wO1pLNd248DJMkf+KpdcK/Ve+d+/2U65Yxkl0ZhiVHZcMcOFiyGaz9Oij+XBa/B811qlG8qJrMN1g==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5880.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382ad91-c840-418a-0851-08dba2dc9cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 06:54:20.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtChV2IuqcDPW5jbg+xgvynSxds1fn9HIAG/m8yMD4zhVzbgB+iN9ysw1P3jT3zqbwJ5sSyF3RKK3rNI1Ul9NTcYoHvLch5mK6VvmXsKEwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5773
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 06:54:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12812

--_000_OS3PR01MB58804858E28A74C02D594823951FAOS3PR01MB5880jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
Subject: [PATCH 1/3] linux/cip-kernel-config: Use latest commit

Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/li=
nux/cip-kernel-config.inc
index e104200..51b17c6 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append =3D " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \
     }"

-SRCREV_cip-kernel-config ?=3D "a28b7a678418287b12161975fe8b9b04a3cc8c88"
+SRCREV_cip-kernel-config ?=3D "aca5978b5abf93b20df4efda067c3a3f461476e0"
--
2.30.2


--_000_OS3PR01MB58804858E28A74C02D594823951FAOS3PR01MB5880jpnp_
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
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Helvetic=
a, sans-serif; color: rgb(0, 0, 0);">Subject: [PATCH 1/3] linux/cip-kernel-=
config: Use latest commit</span><br>
</div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">Signed-off-by: Nguyen Dat Tho &lt;tho1.nguyendat@toshiba.co.jp&=
gt;</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">---</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;recipes-kernel/linux/cip-kernel-config.inc | 2 +-</span><=
/div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)</span></div=
>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recip=
es-kernel/linux/cip-kernel-config.inc</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">index e104200..51b17c6 100644</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">--- a/recipes-kernel/linux/cip-kernel-config.inc</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">+++ b/recipes-kernel/linux/cip-kernel-config.inc</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">@@ -14,4 +14,4 @@ SRC_URI:append =3D &quot; ${@ \</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp; &nbsp; &nbsp;if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D=
 '1' else '' \</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">&nbsp; &nbsp; &nbsp;}&quot;</span></div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">-SRCREV_cip-kernel-config ?=3D &quot;a28b7a678418287b12161975fe=
8b9b04a3cc8c88&quot;</span></div>
<div><span style=3D"font-family: Calibri, Helvetica, sans-serif; color: rgb=
(0, 0, 0);">+SRCREV_cip-kernel-config ?=3D &quot;aca5978b5abf93b20df4efda06=
7c3a3f461476e0&quot;</span></div>
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

--_000_OS3PR01MB58804858E28A74C02D594823951FAOS3PR01MB5880jpnp_--


