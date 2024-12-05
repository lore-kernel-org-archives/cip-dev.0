Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDBE77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 10:05:42 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web10.7238.1733393138285527275
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Dec 2024 02:05:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sMJc9bx/;
 spf=pass (domain: siemens.com, ip: 40.107.22.57, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/+i2zA2CL/ZK/2gF4ivjMiT/iLZ5/+QRQYpXHgXF9pts61JVnZY/bkC88C0p4E33Ywq4CF4/5NpXPQhNIFMYi77OeUNwJ3Efx8vd1xnF4QFLUNsgLSecBVYgBDpAs5iTzibqJL/7OFbv+/cxQfJV9YfJf1pZcjiEpjVQmWMGwFdMtt9WZcljGUUM3G71i+k1B8jxnHCt3n3rnFMuvwaEXEMf8RXcZ5kaeh1D92UppnDSCd4wfa3ThWSMb7bLCiV0LAgeiMmpDNl2HTFl5MGckt0J5eMUuVUeCZRcdXh7F6udwPa6x7mItLbn9SCVsVxQ/qZMnh7GoF41dLg3XgWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om5Q0BCnzD9HAaMCDmkjMeeB6kJ06s3sVcqbRkz+QqY=;
 b=SidEHQjUtqactcxGCnFt9Gu0c3V/Q4cxWnxVFKCRyG6hPBAdRbDqoBnKdQtB3yG/aLPBabQeEmjd8qrpvPuWBngq6G7GOcUCDJshyVkV1hxksVTxxJrUlAG1YxXxgfXcyVLmJz1N5Y2YNiN5KZi1TmKSjgxdivKXysuj8ZQa+MbjGwqyeyur8NTixQqXXgozHAkEHP+3JjZjExlJ5R7iPRwWh8s/kmbTuzyeNrM0Vq9JHxHZ7wWBiE3sGCuMhcYHy1F9EOeRDvRGH3VtkTgcMlWCzUmcI7FlFJKI/IVhpQmei4MyFzwlDvCf2fycS+9YNYoJL7sa42LkAfDECDeneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om5Q0BCnzD9HAaMCDmkjMeeB6kJ06s3sVcqbRkz+QqY=;
 b=sMJc9bx/QY5yx3AAJYxorD6e8LeTGjhaqHJOKJNpIPN+j+mpG+KlTg8sguQmpfFc5QfRiJTiSdu80MqYaFV1/ASMOnxFlfjAgo8FJK64j3maXgKw2WxBGtYJaWxi6/2K0qQIIOw+9MRmJG1nJvczsAXEZnBathRpEcFthp2wb1OnUUX7Ks0H2EXMnHYmJDW3OzIl5DjAyEe7xBT4+tArJPS7yanAEfxON2FLzvXwZ14z4N7twya1NLuYgfZUvM9EVdR9ZwvjNZjicDFRJKkrnCgH0fQ7sIkkH1AefNXbF2dcyGNrIpPn71sFPhkQSeG5FiQ8JjVwlQYMNj59X5w8QA==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by GV2PR10MB7990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 10:05:32 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 10:05:32 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"fabian.blaese@siemens-healthineers.com"
	<fabian.blaese@siemens-healthineers.com>
Subject: RE: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate
 PCR7 after unlocking partitions
Thread-Topic: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate
 PCR7 after unlocking partitions
Thread-Index: AQHbRMm0XM2gEREbgki1mdgmjhpEprLXcIUQ
Date: Thu, 5 Dec 2024 10:05:32 +0000
Message-ID: 
 <AM7PR10MB33200735E8FEECBF4CF8023086302@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
 <cc43a620895a8ddcf6745c7eb4564344ecdf74af.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <cc43a620895a8ddcf6745c7eb4564344ecdf74af.1733151072.git.jan.kiszka@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=08a66a82-d97a-440b-a7a6-a47ae5ee35a9;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-12-05T10:04:18Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|GV2PR10MB7990:EE_
x-ms-office365-filtering-correlation-id: c2393429-3be7-40b8-9b66-08dd15145af6
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Z0xuMDVMOVBGKzhET2I4NXNUS3BRdlVtTE5yM0JFQ293MVhvUytOR040ZDA4?=
 =?utf-8?B?dUM1OW51aG10WnlOTVE5ZERrLzZCVDRPOUYvS05rdjNQOUtCVzZoOElSOWlu?=
 =?utf-8?B?eXlIRklYM250TmZPTmgwT0I5TzRIUEhFU2ZFWFlQTGRYTCtzSS8xdVRxTlY0?=
 =?utf-8?B?WUlHQVM4ZnFMZGc2dUZaYmlOQktid0tDcHMwZ3JoNytDdllJYkY1MTZUL2xu?=
 =?utf-8?B?OEJDNFAvUFNEZm5rN0VzaDRCM2o5eFo1citOYXQwWDFnaFZxa1UyanRybmVK?=
 =?utf-8?B?UXptOThUMFdvMzlVajZZOWtqWWtXSG9DK2JsVjd4STJSUjEzY0JFUnNkMUYy?=
 =?utf-8?B?QjdNQ3ZMaGgxR1BuN2ZuZkhYdUVUcnJHTzdQMXNYakUzRm50OU1WS2lweVRX?=
 =?utf-8?B?TkhaTlVOSXl3aFM4K0oraGlnaS9BeE1yNUdtS0Y0UGhzMFhiWnZsWWdKR2VS?=
 =?utf-8?B?ZU1ZV3NlN3NhQVloK0QxbVhIUEQ0MXo0V2E2cmsyUTQ4anNiQU02OHBYQ3ZP?=
 =?utf-8?B?b3VkV1RnQVJoQTB4Q01kSk9ZUzJhRlJscjNacU1VS08xNml4QmVaNE9yUDln?=
 =?utf-8?B?K1V2cmw3d2xLOUVMMzZGWFhLOWVBenZJdEI2LytEaXZWYXJ3azN5c0kzeHl4?=
 =?utf-8?B?aEYrUGYyZ2Rjb1lTa0Q0OUt0dHVVZHBVdDNTQlUwZDVEekNRSjFEUS9obWxh?=
 =?utf-8?B?TmYwa3IzWVFlY2NXZ0N5a2gwSnU3L0UrSnN3Tmd3T1cxYXcvNTF2MFNDU0Jh?=
 =?utf-8?B?NTNiVmUvT1FFTFRya1ZvdTBpQmdTT1d1bUhKcGdBUnR0cUtTWk13YWFML214?=
 =?utf-8?B?dEtLTU1PSzJVckRLdWNjSk41c2NSS1g0ZFpndmJOdGpYL3pWSFhsUkIxcE1p?=
 =?utf-8?B?d0g2VEx0SC9YS0VHZzZ2UnYxMkFOSnFBT2pwZExEdTlnMDJYKzU3Zy9vUXMy?=
 =?utf-8?B?NnRNWTUrbmMyZ3ZyMWh5aHJGTnpqcXI1YUU0djNJemVJMnpwREdvRkFqZHAz?=
 =?utf-8?B?QTNhU3h5QWwva1IvWmpmMHN1SEhKRXN0Y25Ca1Jaek16Q3JBNGdRRmNRdTVN?=
 =?utf-8?B?bUpMVG1vSHNDMlNlcUxIL1FuRmU0clQwb0tVT0NiNUdyWTFoVzdCWVp6azhU?=
 =?utf-8?B?aDBIdGtDbkh4NzdwZUdOQmRIL1lWb1JsbnB2NU1OV1AwQzNITVdpQWlMSFFZ?=
 =?utf-8?B?aFhEU2cvSkVmeEFmaEhXb1RReTVmYWIvdDJmekJYdGtKa0kxdGtJTGFNZEpN?=
 =?utf-8?B?WU14S1FIQXNNbFplQXV1Snh0VDRJQllBbmp4Y20vRG9remw5QldOSEZ6UUNM?=
 =?utf-8?B?QzZrSjIwTHlMQVlhWjYxRWdDUE8xOTREVUpBemJrb3pheXdvQWFlby9pcFRQ?=
 =?utf-8?B?WU55RE90U3BHNU1NT3p4RWRtSjVSRHNoRzJGWTF4bW9Yek81N2RqN0MwRVo5?=
 =?utf-8?B?ZmI0Y2ZxdjRENUdCSUtVTEgrbDU0bHpaVVU3dk1Zb05yS1UwRm1tK2JRMDBO?=
 =?utf-8?B?Rlg2U1BRcUlJTXF2UFVERUJ4N01KaEl6N2dic1czeVlVcXNVTWNSZkozZElz?=
 =?utf-8?B?cWs5QVNMdHJLK1ZObXBHRVJMZTJyVEdiUm40d25vck1kc1pMaE51WElaTVZN?=
 =?utf-8?B?S1hDZ1BWS1gvYXBocFRrNTExZno5TnBrRWYyT0xXSWtZdWlRL1RIUEpUM1dC?=
 =?utf-8?B?a1o4d3lGbkxHb0ZHd0NDMC9VZmtFcG9SemswdnZqWDlaSDdQN3FveFBUdUhC?=
 =?utf-8?B?ZFczMTVYN3lwbUplUXZoQ0haUnR5SGxCcjlvVXU5ZzFGSE9uRTFWdE41TDVt?=
 =?utf-8?Q?6WloQq8fGoNM3qXICq4Mnf+J8gSQwiv78eQU4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q3UrTG5kUFdUVm1oWFNXekRpaHNDeGdobWxEQjFQSkpKemNUeXF3MmJwTDcw?=
 =?utf-8?B?MFpRS2RqNWl0TE9DMkZjTkxsZG4yZXFRWnU2RmpQQ1oxeHJKY09PRnk4Q2Y0?=
 =?utf-8?B?ZTJlMDZqY1pFYXQ1ZWJ6ZlJFR2o4VGQ2Z0NSSnhaN3UzNFRKbVkrZnE0MlBC?=
 =?utf-8?B?QjFQa2MrVnEwenVRME0rWWI4aWttNWIwbkE5Q3FQamNtVnZyYkNCWGdGV1h6?=
 =?utf-8?B?Ui9MTUN0bVlyeEFoRjV3SWU5My9aYyttR09ydVROM3M2R1JPTHRYQjIvQWkx?=
 =?utf-8?B?OHB1TDdKMVdVUWxIdFpEdm9KR3ZOWkZIbzFvYnJyemJFYlR5VWEwR2llVklI?=
 =?utf-8?B?TjBMczRrR1VWdWtoTGljM0U1dXhQQVBXYjNocklrZ0dMTEEweVRjVm1QOEtO?=
 =?utf-8?B?THVqd3FIQ3VKdkE0VnIvRzliakRRTm5aeEs1RDBTZjZXMDk2NW16Y29nQ0M2?=
 =?utf-8?B?R3NMaFhFSU1QdFB3d0FmR2xBaUsvNGV5M0kxUFdYdUtwU0JWbnQ0QVFaVDUz?=
 =?utf-8?B?S00yN29iL3YvZU1uUGdTQWU4ZEI2a2txOUZWbVNjeWp1bjNHQXFQc1dtLzFM?=
 =?utf-8?B?TmhxQTRvY21BeHk1UkgvSDdVa2dHeWR2T0Q0cGFla1llY01OZnBXTHpPMFA2?=
 =?utf-8?B?UnptM2RaMEkwMlhrOVBZNk1CMENpSGJxV1NYY1dRMWJJV25QYjIya3FRZktG?=
 =?utf-8?B?QWFadys3NituWldUZnFkZ2ZlclF3dzlwbkFLR1BIdUNkQkVLZjRSeHZpSjJu?=
 =?utf-8?B?Z01HV1JyUUJCbDhwc1VpVGVCSUNuOTIwZWszamhCRmlPc0hMVVVRUzBFZ3RZ?=
 =?utf-8?B?dTZOSXZsZjJUdWk3ZWhyT3RlbWMxajhMa0xtWEIvN0hVM0dnNCttWFBvZHlC?=
 =?utf-8?B?WnZmMGRCcFMxZ0F1VlMwb2RDaTJlSFdIM2t1bGZqYnZyVXd2ZzF0bklOaldh?=
 =?utf-8?B?TFZJV2EyUHRMSFRTMVJOWWt1SXdnNldyR0l2NTQ5YkV1RU85OWQ3WFN2eGZp?=
 =?utf-8?B?algyNkJHZXJ6KzRNRnlmdjNhSlF0ZnNJWkhoRkdyUGVHYkRIOERuUHAvZ2RC?=
 =?utf-8?B?V2VnMjI4N2lvU0x3VHJTclNwRmxGUFFMS2xLWWYzRjYzYjViVFdVYnZKck9M?=
 =?utf-8?B?bG1rd1k5bjN3dDc4RTYyN0I3clphbFpCYVFsZUZDRTd1YWZqZHkxNTZJaGRK?=
 =?utf-8?B?Y3RaRC9pdmNaWDRhRzQvRm5WbjVWNzI3UXlZZ2VqZ1FsTWx2RG5VU2FqUkZ5?=
 =?utf-8?B?RTZUb2lYMW85bndRVzRXME9KZmlzcVF4S1gzM1N1eTV5TGlsWGRmTTB4cC9x?=
 =?utf-8?B?QWZCbXVYZnRZQXBaRFFVNDJKTnluNUlBd1NzMlZJQ1liNitvNVpJZGN1cllM?=
 =?utf-8?B?dGlWUW5QL2lHdVpQenYxRWo3WCttUHN6WkpOaHhYYWNtKzMzeGhwc0FuaHVt?=
 =?utf-8?B?T3dsUkJYeXRDYUVYL3hGTklsVWNPVE5iei91R0tyTW5ZUHQ4ZDd1U0VYNXRI?=
 =?utf-8?B?a0dDSGFHa0RmK1VmeHZPVzhoNVNrK0hVZktBN0xaZy8rb29xNFpUTmhiZllw?=
 =?utf-8?B?RU5EVkQyVlh0RmdMZko4bHNVY0M3MVJTWW9UZytuNU5uU21QZUsybzNDc2RQ?=
 =?utf-8?B?TVl1YklRelc0Y2t2dlFGVjdWMTdWVURuYnJZa3JSQnJmRmlBeDlWYzlNbWZN?=
 =?utf-8?B?Y3dXVVU5VjQxb2VtV2dXWndYTHJrWVdLNXcxaFR1ek8zOWdvbXFZY1d0OHVF?=
 =?utf-8?B?VDJXSHlqV0JsRUw3OXNPd2ZHMXFNUG9iVGJsUXFDQnp4cWJqZlVMamdoUGc0?=
 =?utf-8?B?V2RlY0Q2bG9rbnpQOG9aNFJDdW9SUEEzcUlIbFZ4NGw5TGhvV2hDQXhra3hB?=
 =?utf-8?B?WWp3aDY3bzdXby84K01HMGwrc01QcDNDckpZN0xKOEZhRFJ3eWg2YTEwbE5m?=
 =?utf-8?B?TlVnVXBsQUVwdGUwMEZwRkhrbk10VXh4ZHZ4SHVFTDNHWkY2RVVBeGpsb0Zx?=
 =?utf-8?B?UFRUaFB0SnFrSmJtcTJMMnVBWWo0MFNJMFRIdG9WL2lQQnNzTzA3U0lUbnpW?=
 =?utf-8?B?TTUzZDZEaTA4OEsvSnJzdHcrd0RwV3Nab2UzaDVBMWk5bjZnRmhpMk1tTkJP?=
 =?utf-8?B?SEZlT0JtQ2hHZFRJMGtETExuOFMyYWMxUTd2a3pzZ1paV3dzeWM5TE43VnE5?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2393429-3be7-40b8-9b66-08dd15145af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 10:05:32.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcTUYtq8mkryhNRJ1EzerSVs5+AF452eyCUPaCc9VrSsWk7G/Y4NikUUEYOGXss+lALiTBYoxD2aDMx5FoU6VyYHdgJNw/IFHNQ9PJ2RtKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7990
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Dec 2024 10:05:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17331

PiANCj4gVGhpcyBhdm9pZHMgdGhhdCB0aGUgcnVubmluZyBMaW51eCBjYW4gc3RpbGwgYWNjZXNz
IHRoZSBwYXJ0aXRpb24ga2V5cyBhbmQgcG9zc2libHkgbGVhayB0aGVtLiBJbiB0aGUgZnV0dXJl
LCB3ZSBtYXkgYmV0dGVyIGFkZHJlc3MgdGhhdCBieSBtZWFzdXJlIGJvb3QuDQoNCk1ha2VzIHNl
bnNlIHRvIGxvY2sgdGhlIGtleSBvbmNlIHdlIGxlYXZlIGluaXRyYW1mcw0KDQo+IA0KPiBTdWdn
ZXN0ZWQtYnk6IEZhYmlhbiBCbMOkc2UgPGZhYmlhbi5ibGFlc2VAc2llbWVucy1oZWFsdGhpbmVl
cnMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMu
Y29tPg0KPiAtLS0NCj4gIC4uLi9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3At
Y29tcGxldGUgICAgICAgICAgICAgIHwgMyArKysNCj4gIC4uLi9pbml0cmFtZnMtY3J5cHQtaG9v
ay9pbml0cmFtZnMtY3J5cHQtaG9va18wLjUuYmIgICAgICAgICAgIHwgMiArLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10
b3AtY29tcGxldGUgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxl
cy9sb2NhbC10b3AtY29tcGxldGUNCj4gaW5kZXggODM0ZGVhMjIuLjRiY2I0Mjc3IDEwMDY0NA0K
PiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2Nh
bC10b3AtY29tcGxldGUNCj4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0
LWhvb2svZmlsZXMvbG9jYWwtdG9wLWNvbXBsZXRlDQo+IEBAIC0yNTgsNiArMjU4LDkgQEAgZm9y
IHBhcnRpdGlvbl9zZXQgaW4gJHBhcnRpdGlvbl9zZXRzOyBkbw0KPiAgCWZpbmFsaXplX3RwbTJf
ZW5jcnlwdGlvbiAiJHBhcnRfZGV2aWNlIg0KPiAgZG9uZQ0KPiAgDQo+ICsjIGludmFsaWRhdGUg
UENSNyB0byBsb2NrIGFjY2VzcyB0byB0aGUgZGlzayBrZXlzIHRwbTJfcGNyZXh0ZW5kIA0KPiAr
NzpzaGExPTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEsc2hhMjU2PTEx
MTExMTExMTExMTExMTENCj4gKzExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEx
MTExMTExMTExMQ0KPiArDQoNCkZyb20gVENHIFBsYXRmb3JtIEZpcm13YXJlIFByb2ZpbGUgU3Bl
YyBbMV06IA0KDQoiSW50ZWdyaXR5IG1lYXN1cmVtZW50cyBvZiB0aGUgcHJlLU9TIGVudmlyb25t
ZW50IE1VU1QgTk9UIGJlIGV4dGVuZGVkIHRvIHRoZSBQQ1JzIGFsbG9jYXRlZCB0byB0aGUNCm9w
ZXJhdGluZyBzeXN0ZW0uIEFueSBIb3N0IFBsYXRmb3JtIGNvbmZpZ3VyYXRpb24gY2hhbmdlIHRo
YXQgb2NjdXJzIGFmdGVyIHRoZSBIb3N0IFBsYXRmb3JtIHRyYW5zZmVycw0KY29udHJvbCB0byBh
biBvcGVyYXRpbmcgc3lzdGVtLCBvciB3aGlsZSByZXN1bWluZyBmcm9tIG90aGVyIHBvd2VyIHN0
YXRlcywgaXMgdGhlIHB1cnZpZXcgb2YgdGhlIG9wZXJhdGluZw0Kc3lzdGVtIGFuZCBtZWFzdXJl
bWVudHMgb2YgdGhvc2UgZXZlbnRzIGFyZSBleHRlbmRlZCB0byB0aGUgUENScyBhbGxvY2F0ZWQg
dG8gdGhlIG9wZXJhdGluZyBzeXN0ZW0uDQpQQ1JbMC03XSBhcmUgZXhjbHVzaXZlbHkgZm9yIHRo
ZSB1c2Ugb2YgcGxhdGZvcm0gZmlybXdhcmUuIE9wZXJhdGluZyBzeXN0ZW0gYW5kIE9TIHByZXNl
bnQgc29mdHdhcmUNCnNob3VsZCBuZXZlciB1c2UgdGhvc2UgUENScyINCg0KU2luY2Ugc3lzdGVt
ZCB1c2VzIFBDUiAxMSB0byBtZWFzdXJlIHRoaW5ncyBkb25lIGluIGluaXRyYW1mcywgaW5jbHVk
aW5nIGV2ZW50cyBsaWtlDQplbnRlci1pbml0cmQgYW5kIGxlYXZlLWluaXRyZCwgSSByZWNvbW1l
bmQgYmluZGluZyB0byBQQ1IgMTEgaW4gYWRkaXRpb24gdG8gUENSIDcgdG8gbG9jay4NCg0KV29y
a2luZyBvbiBhIHBhdGNoLi4uDQoNCkJSIEFsZXhhbmRlcg0KDQpbMV0gaHR0cHM6Ly90cnVzdGVk
Y29tcHV0aW5nZ3JvdXAub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9UQ0ctUEMtQ2xpZW50LVBsYXRm
b3JtLUZpcm13YXJlLVByb2ZpbGUtVmVyc2lvbi0xLjA2LVJldmlzaW9uLTUyX3B1Yi0yLnBkZg0K
WzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9zeXN0ZW1kL3N5c3RlbWQvYmxvYi9tYWluL2RvY3MvVFBN
Ml9QQ1JfTUVBU1VSRU1FTlRTLm1kDQoNCj4gIGlmIFsgLW4gIiR3YXRjaGRvZ19waWQiIF07IHRo
ZW4NCj4gIAlraWxsICIkd2F0Y2hkb2dfcGlkIg0KPiAgZmkNCj4gZGlmZiAtLWdpdCBhL3JlY2lw
ZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlwdC1ob29rXzAu
NS5iYiBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1j
cnlwdC1ob29rXzAuNS5iYg0KPiBpbmRleCA3MWVlNDRkYi4uMjE0NWE2ZTUgMTAwNjQ0DQo+IC0t
LSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlw
dC1ob29rXzAuNS5iYg0KPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQt
aG9vay9pbml0cmFtZnMtY3J5cHQtaG9va18wLjUuYmINCj4gQEAgLTQyLDcgKzQyLDcgQEAgSE9P
S19BRERfTU9EVUxFUyA9ICIgXCAgSE9PS19DT1BZX0VYRUNTID0gIiBcDQo+ICAgICAgb3BlbnNz
bCBta2UyZnMgZ3JlcCBhd2sgZXhwciBzZXEgc2xlZXAgYmFzZW5hbWUgdXVpZHBhcnNlIG1vdW50
cG9pbnQgXA0KPiAgICAgIGUyZnNjayByZXNpemUyZnMgY3J5cHRzZXR1cCBcDQo+IC0gICAgdHBt
Ml9wY3JyZWFkIHRwbTJfdGVzdHBhcm1zIHRwbTJfZmx1c2hjb250ZXh0IFwNCj4gKyAgICB0cG0y
X3BjcnJlYWQgdHBtMl9wY3JleHRlbmQgdHBtMl90ZXN0cGFybXMgdHBtMl9mbHVzaGNvbnRleHQg
XA0KPiAgICAgIC91c3IvbGliLyovbGliZ2NjX3Muc28uMSINCj4gIA0KPiAgSE9PS19DT1BZX0VY
RUNTOmFwcGVuZDpjbGV2aXMgPSAiIFwNCj4gLS0NCj4gMi40My4wDQo+IA0K

