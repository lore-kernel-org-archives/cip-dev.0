Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53287D64063
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 16:28:56 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web11.17062.1731083326795361957
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 08:28:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SDPvxe3q;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6kXR0xI1x64IoBE6KMNvCm3+fcE7Om4pOJQBaAboSEulD3wlwa+tGD/EjwB5Ba5H9LOrSHMHDTz3XGxLki6TI2GGTyyK52T8mnwfGS5B071Highfa4/WyPlmyJWLFcDeDYE3lOXMXbFQwdXfI3GRFnVCTUyMj6CZFA0g5hj9vCNPWmnudqkg9LKfzGI5Z2Z7OcljLzZ4RS+IGuWFyUmpogQmwVIubXUVCYhoINHEql4RIWZKR+M4R4H23iERVj+Jv4eIpcwFlux9RcMn6FvKmixRoDpcL8picKe+DvzwL3jnP6eR9HQxGBZAnt27UA1rmNWMlb2dO4VdT4OzoB6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Iw3xkgImvBnv2FSjsgXi6TQIhh/Lp+G17XMdCoJXZE=;
 b=ozfgmMtoO/wh+BIX5vr2luPdzlEYZ2RpT2gHc05ArNbsKYX/St1POGT2R+uMhlaYt0HAsnn/zsjVC7ZN+DINOzLBSq5iK0ZZKMC6nrk9cfA7qJF5kdpF1BahsYucK3mLWSyz2CGBvBu9xGBrC36PLCyici2bs1MzhtzPg8TTShLyHLmAPJ52GPaQ9RxvZfLCBryJjmePj5S1sScTci/26y6yYzkQ7VISPtt+ikJ/tEoAq0RTVqVsksU7XDfv7BQTGqNoSqVkHedWGNrlPHBJhszxriZ3Y0zlANam/W/Z6UmQQDTwJxohU4sLC4sx9PJ5GT4km2jmRHdgT2YiGnVO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Iw3xkgImvBnv2FSjsgXi6TQIhh/Lp+G17XMdCoJXZE=;
 b=SDPvxe3qQh1zvY15jLNSgylCBBAzuWrXSwGgl40lZVmQ9UUc1zQrSMC2XfZlDuWOB29ixvrfPIXMUL3pbff95ycFOM8kz5NnZJJlIroGLIPPUrRtKNnLMZYJY6MG2V8Fdrcqddka4TaP6F+4BXjs2O9sDc0iBLZfYWUF3DtMspdMvu3yt+fkb0d035KJsGbQhLZVf1e8JuQFcOkw70Xg78VztrXnNDWjW8F01FvDceiKQcNZoLts92LnJRVld39LazCJCbCBgzpKQ0k6o1w0nz1kW6LmzetS+/wK9gipUmGrA+MrC91KPDvFliSOZ8xkFN7yVPXxFpjxnHsNPPu+7g==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by PA2PR10MB8942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:416::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 16:28:43 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 16:28:43 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Topic: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Index: 
 AQHbI+q4NaXgEhKYgkiz6PQsKD/HorKWEKyAgAAP2hCAFHuKAIABX72ggAFi9ICAAC5OgIAACXAAgAABKgCAAAEnUIAAA/WAgAAGehCAAAh1AIAAAqig
Date: Fri, 8 Nov 2024 16:28:43 +0000
Message-ID: 
 <AM7PR10MB33202DC3FE6C2AFD951A20E7865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
 <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
 <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <0ab55902-7b85-42ac-81c6-1d8214d3436f@siemens.com>
 <AM7PR10MB332073758FFEA64F2CAEB1A8865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <ed6122d2-113c-43d2-a6fe-8bab867ec51d@siemens.com>
In-Reply-To: <ed6122d2-113c-43d2-a6fe-8bab867ec51d@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4e9ec234-a052-461a-9fb0-3725bd9bfef1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-08T16:27:26Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|PA2PR10MB8942:EE_
x-ms-office365-filtering-correlation-id: 27c1db37-773e-409d-5c99-08dd00126954
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?brhQ5dMNLCI2U5azchZ05VzARlgXJbaF3fu9DNnZ/VhTde3+M2GpFJRWtb7I?=
 =?us-ascii?Q?GoxkX1qzgy5nxiadJx9pJLETtX3/yV9mQDh2ogUWR+npPgdFnC4gWycu7BMr?=
 =?us-ascii?Q?NfXttLN22UQEN7ZtbrAQbv/Y18SI1YktCta63j7NAk9Y8hJ2y9M2h9LQijI1?=
 =?us-ascii?Q?oz/ZkRQ05TC/sgvECnDNbrZ/O68cX9aGCGTbUFVNgi1rzgtieTL2f4GoEX1N?=
 =?us-ascii?Q?Z5+DuLQLRGn+iCAvv4eB2Rclo9ZzK51OPDuj0xV8AM6GWePjDJxESuhlgh8u?=
 =?us-ascii?Q?RZq623hIAsGE1I8l1BokXp/DcYmsEKmifgJFzNnJBMlylNYML4NQzhqGfxa7?=
 =?us-ascii?Q?+5UbPy2GSvtyiXAXwH5f4OZs3fj6oULFaqF5wHnDTT+yBGmaZ7t064maFgWG?=
 =?us-ascii?Q?VO9OMaG6/ZP60gcymlBUW2nVQalnBhko6uOU8270fWJkUX8HUHxqt9Rbt0t5?=
 =?us-ascii?Q?Vwy/x6mRt1z8Kt/orX96gyIxfPYmuso/Dp81JUtU8dYNG9XoVeTFpFDosT8Q?=
 =?us-ascii?Q?pgpSgbRxiTtLlQRAuhOCFcc7OFM4PUeRabqfs5UOakVkM0C5NhS8nQhT7lh8?=
 =?us-ascii?Q?/d6M2JbqaWBR/FDppYj2mi9mivwnxLKUBbGOYZ7xwjO8FDE74vLD9E1Vze+/?=
 =?us-ascii?Q?eJGMQ/ZdsD+PXMBkpIvOFJ16Mzj89tjAc6GYbz4uigQ73/f6t7Z4Ddnmn/Bj?=
 =?us-ascii?Q?IL5R8EOWgonsq7hXwA8a01fALO4weYLLkz5MIthCj/Vd94F7E69U0TWkpl7Z?=
 =?us-ascii?Q?awsfwvPMxbeAE0yQoV0M/AZQarBlgCFNN1Kjk34iXfh0xv2Xl9Q6nTRWmk3U?=
 =?us-ascii?Q?1xEVjFqWGYZzhqTdsFyZ/k1j6kEEltaeFaJTPu5hsFclhXM3HwhlzdyFCB7s?=
 =?us-ascii?Q?4SbvnDIdxgBZrO2W5gmW+XG0KkLbL+rotr1myyU5wKqgBh0npzdH16rXLiqu?=
 =?us-ascii?Q?0Hu+vxNz8NM+qgXjtPo2gOdmB624pA8mGcQF7DkVWOhcbPEtmtGiItFEeHlP?=
 =?us-ascii?Q?UasMPlAFh4y/BsUx+pLPo0wkJ2nZjiIdI1XOpGpou7Z25ffD5RplcLVWps9K?=
 =?us-ascii?Q?XQy409/qmSzcPqLAPkhJ08jlRe1+jFd64PXeJCioCRbV2ooVusDF43dzEgzm?=
 =?us-ascii?Q?UaWSykvDrq18JoXsiCeo8HG7hgWZcLwnfPiahp4Asqt+YzgeHx4T0Zi/CO0+?=
 =?us-ascii?Q?BK49i3+8Zd76WIuKQZep4TI2YlRmFBxxMmPIYiDia3O1XSexV9YLUBBQPX3h?=
 =?us-ascii?Q?C4fgwQopq5kts93Dyn1OYHChf5ggSDE+iRhgk8IGvDscvUPH8UI/6qpvjYnq?=
 =?us-ascii?Q?YMpjGwdAFas1h+Cbco3+Re9U?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mCISh0cLHtsyihOMDCHo4JhrrrTFz/4b51suP6vJCprwC74k2yT/xCeB/yjK?=
 =?us-ascii?Q?QishWGAw+5XD5nO/9N2u4eQF7703x0e5dlQhy1giDK9kJFAKaOndu/KItljw?=
 =?us-ascii?Q?2UhpwzxiMesjJyRiopTHGG/CwBmXGPcRvKJgDKxs07b2a3+eKJAlNiOB6YSk?=
 =?us-ascii?Q?f0o9RYG2o2Y633NJ7l8E7YDuI6XSeWOa3y8dJ8IEz0+fRxB2xf/q9YV6RDFw?=
 =?us-ascii?Q?WicW35HXGer4Y8jH+VeMUx1cYGWM2ZRFCiqmkpoX2+Rn4tMOLaWme5PgvQDA?=
 =?us-ascii?Q?AtC+BCZC1fRJ9dKYXxlpGKKUaB58IU/ZV7x0rgwjNUaz4G3XQDZvSoL0Z2RM?=
 =?us-ascii?Q?XVcOvxj4XlttYayw12Kiec65iQzUqOimR3hN+SNDEiUS57K5SoCvXxL3ChuK?=
 =?us-ascii?Q?Xk1d1eIXm8xRANgDJi18tba/NUh53BmXAmDCyq3Fh1m537AB8/BfNU55ia/i?=
 =?us-ascii?Q?shHmQKZYrfS82vL4FLFcwAsQ6h+N6PSmbfmEkAdNzxrIcYbqTL6Fl4sbCVqj?=
 =?us-ascii?Q?ai5dyd026H0moQE0U+r+AFG5PJLd/6F74BT7GhevavToU7xG5w/cFp7ZUXCI?=
 =?us-ascii?Q?oYrYI3rBs1v4wQjYX90Zh55XUUFN/ITEFtoNIiCDo3Wk50EpSOyqhx/r2oFP?=
 =?us-ascii?Q?foPXgLcL0n7uSgJdyiQ07mvZqe41+9U+cTSGEc0HUyLs8Dp4QCbXt2/b2vYK?=
 =?us-ascii?Q?4L7Vhdw+G7hgOGDmA/8+QbxLNIxZoj+zbKQEMuvIFR0jEH1VsCM9MJWXOVoF?=
 =?us-ascii?Q?0T6gRdUrsSc3NAb5dI6x2AG7M3lJIKunOwfh0qjQ3UJjgqF4+SKf48UwI2pp?=
 =?us-ascii?Q?rhUkjwps4gvS3bQDoMeqM1NkBqbqhfDNWqX1/vXPTqAz2yahVXecWdu3KESZ?=
 =?us-ascii?Q?8TKo7sVAeBwEunEk09O8bNRUskSJlDYZ/s9BUeQn65droTKgH+lo0S+xG6+3?=
 =?us-ascii?Q?sKkIUalBJkY3V8s+s41kRGkdm2dVF+GKLTB2mHM9ark2Aj2UraVGeTEBM5E8?=
 =?us-ascii?Q?NttF31SmO0serxdUZlmRYjsw19xrDqofqmICLQaVAXWZWu2bZDfR5afPAZAu?=
 =?us-ascii?Q?Tll/2Zb/6ue6hk3X/oK/T9rqT+Yxno/91mWJfvgwqvunV8IX77EMyeA0Wd5m?=
 =?us-ascii?Q?T+uzhFzKF2ux5MCyTr0QrBxsDgYPBAKukwIPh9QXAnphI3NpIoBACOjhUFPN?=
 =?us-ascii?Q?ZVEeA37XxTMeaLYx43ABwIfs93HGun5E/4JT/NuzdLHLz3q3BY9KDNRKHHQP?=
 =?us-ascii?Q?SLnnnz2IKMSsTM9htHkJpK30kLIXOJ1cx0UKfFUmrcorWBW8SYvCzZuL63v2?=
 =?us-ascii?Q?OsT0KK6xzi4SNlxvWxciutM3opovqUoU+U3xWhkwY/680vXciuSh2XT21rPp?=
 =?us-ascii?Q?VLx0o7gHl6g/v6OvAV8ZkBvsgItB8Nt0ehZ0voxVaKdrIwsd4bLbylZUIwqj?=
 =?us-ascii?Q?LOmp8zQ127RwVZ4m+Lw/ONXBOwX3fQ+XKO85uSEVUsTNBWF7enYoQvprQSTn?=
 =?us-ascii?Q?PEaUzy38zIHSIW9WbuFg8KFMeWT1kgAEGWBRK0DLYsRFhKkUGHJdzQk3eLTJ?=
 =?us-ascii?Q?NtDfufdo2ydRv7U+wzz0MkuFUohVTH35frAfHBzirGwtfByQK8c3wvi3csdW?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c1db37-773e-409d-5c99-08dd00126954
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 16:28:43.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiIgsC66x+aIs3BQeCivrQOG7WygkdXXT4CxMcFfR4pl/x+qzoz7N0Dsh3Z2lTObfDB3u7ZeGqdwnWolIYndhnSwBBUbsG78LSA/Sx/KulE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8942
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 16:28:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17233

>On 08.11.24 16:47, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> On 08.11.24 16:10, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>> On 08.11.24 16:02, Quirin Gylstorff wrote:
>>>>>>
>>>>>>
>>>>>> On 11/8/24 15:53, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>>>>>>
>>>>>>>>>> Quirin and I discussed this a bit longer today: We actually
>>>>>>>>>> should remove the need of expand-on-first-boot to access the key=
 again.
>>>>>>>>>> And that is also due to an idea I picked up yesterday to lock
>>>>>>>>>> the tpm secret after initramfs so that we reduce the risk of
>>>>>>>>>> leaking it via the main OS.
>>>>>>>>>>
>>>>>>>>>> Our plan is now to convert expand-on-first-boot into an
>>>>>>>>>> initramfs hook that would then come before the crypt-hook,
>>>>>>>>>> thus would only work against the unencrypted blank filesystem
>>>>>>>>>> - problem solved, just differently.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Actually that's a good idea!
>>>>>>>>>
>>>>>>>>>> For now, also for trixie, we will just make the dependencies
>>>>>>>>>> of initramfs-crypt-hook release-dependent in isar-cip-core.
>>>>>>>>>
>>>>>>>>> I guess this is the patch [1] you are referring to?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Correct.
>>>>>>>>
>>>>>>>>> Just to be sure, still, the implementation of the initramfs
>>>>>>>>> hook for expansion will be in isar?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Nope, this ideas fell apart after trying to convert the current
>>>>>>>> systemd unit into an early initramfs hook. We will need to split t=
hings:
>>>>>>>>
>>>>>>>>   - expansion for already or to-be encrypted partitions needs to
>>>>>>>> go into
>>>>>>>>     the crypt-hook of cip-core
>>>>>>>
>>>>>>> ad "expansion for already encrypted": I guess that covers cases
>>>>>>> like in VM/Cloud infra, where disks can be expanded after
>>>>>>> first-boot / installation?
>>>>>>> ---
>>>>>>>
>>>>>>> In many use cases resizing the partition should be required
>>>>>>> during installation / or first boot only.
>>>>>>> That's why, I'd prefer having those steps separated and opting in
>>>>>>> for either!
>>>>>>> Although package dependencies might be tempting to combine those
>>>>>>> and reduce recipes + initramfs hooks, the use cases and options
>>>>>>> on combining those justify a split.
>>>>>>>
>>>>>>> As an example to point out the combinatorial complexity of just
>>>>>>> those two recipes and probably there are even more combinations
>>>>>>> to come when keeping the systemd expand from isar.
>>>>>>> (which probably also makes sense for non (customized) initramfs
>>>>>>> use
>>>>>>> cases):
>>>>>>> My current approach to streamline that (downstream) is by
>>>>>>> utilizing a target-bootstrapper (kind of next-gen isar-installer).
>>>>>>> That means, expansion is not a use case after installation for me
>>>>>>> when running on target hardware, still, when deploying on vm!
>>>>>>> Similar combinations apply for encryption, not necessarily
>>>>>>> mapping the ones for expansion.
>>>>>>> I am aware of the target-bootstrapping/installer approach is not
>>>>>>> desired for many other scenarios (e.g. vm, sd-card based
>>>>>>> installs,
>>>>>>> ...) but it already shows a good amount of combinations.
>>>>>>>
>>>>>>> Apart from that, not related to the initial problem, but maybe
>>>>>>> something to keep in mind when refactoring/reviewing the existing
>>>>>>> implementation: The current implementation will potentially break
>>>>>>> the rollback capability on upgrades from systems without
>>>>>>> encryption yet in case of full disk encryption.
>>>>>>> To mitigate such for upgrades of unencrypted systems to use
>>>>>>> encryption, we must encrypt the partition relating to the current
>>>>>>> initramfs only!
>>>>>>
>>>>>> IHMO Rollback should not be supported - this open opens a can of ...=
 .
>>>>
>>>> I see. Fine for me.
>>>> Then just ignore the part below: "Apart from that, not related to the =
initial problem,..."
>>>>
>>>>>
>>>>> Right, I don't see that use case either. We are covering the initial =
provisioning use case here. Wiping everything is a different thing, and I w=
ould not address that as "rollback".
>>>>
>>>> Rollback in terms of A/B not in terms of wiping out.
>>>>
>>>
>>> Then I do not get what you mean. A/B only comes into play after the fir=
st boot, thus after encryption has been established.
>>
>> 1. Assume you have a product based on isar-cip-core deployed in the fiel=
d without
>>    disk encryption enabled (initramfs was built without `OVERRIDES .=3D
>> ":encrypt-partitions"`) 2. After some time the requirement for full disk=
 encryption gets relevant, and the image get's updated
>>    to support disk encryption (initramfs of update was built
>> `OVERRIDES .=3D ":encrypt-partitions"` set)
>
>I know these requests but they can't be implemented securely (it's like tr=
ying to pull yourself out of a mire by your own hair [1]). Therefore, I don=
't see them in scope for isar-cip-core upstream.
>
>Jan
>
>[1]
>https://en.wikipedia.org/wiki/M%C3%BCnchhausen_trilemma#/media/File:Muench=
hausen_Herrfurth_7_500x789.jpg

Probably not :-)

>
>> 3. Update .swu file gets applied with SWUpdate. Thus, passive
>> partition (lets assume B_rootfs) gets overriden and a reboot happens 4. =
After the reboot we boot the new initramfs from efibootguard part (B_uki) w=
ith the initramfs-crypt-hook active.
>> 5. A full disk encryption gets applied. This includes enryption of A_roo=
tfs partition as well as B_rootfs partition, and data partitions.
>> 6. Afterwards while finishing to boot B_uki using the B_rootfs we identi=
fy a problem / watchdog triggers / etc.
>> 7. Reboot
>> 8. efibootguard setting identifies we did not commit the install and
>> falls back to boot from A_uki using A_rootfs 9. A_uki does not include u=
tility for disk encryption, thus, cannot setup dm_crypt mapper accordingly,=
 and fails.
>> 10. Device bricked.
>>
>
>--
>Siemens AG, Technology
>Linux Expert Center
>

Coming back to the initial discussion (alt: TL;DR)...

I'd propose to:
keep the initramfs-crypt-hook (incl. refactorings) in isar-cip-core,
create an initramfs-expand-hook in isar,
drop expand-on-first-boot from isar (replacing it with initramfs-expand-hoo=
k).

BR Alexander

