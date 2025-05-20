Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED962C3ABDA
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 03:37:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.12805.1747712248063166808
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 May 2025 20:37:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=PMCl/p71;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1747712216;x=1748921816;bh=4s
	w4rG/8LQg1BJOFHe5T0sjMWvkaZC6PDFu2+/1IKfA=;b=PMCl/p71SfFVSMtU9hyHLAWUTaAnFlIO
	EvQ5gdl7Qa/y1G4Qx8FaWwA9BLKT5iObEP6jpjSyxAh3BNQbDPyxxAHocII351YUDGpFrYGXU7Q62
	CGQDEBMb5Se/O7cR+CO6dl4fWIjO3zGpwY3jvunhwPNpGIFfmHIn7H+N+kF4UubF0X/xZEWWau4QK
	RulYXAdoJHGPJ0a11Q35EIX5x64n/UexlcVUfQ1fZfhbhTFSk95TuT4jDvfjtczqNxy1rOJMpcQZQ
	ym26dY/LQVCXo/R55dxnqg/Z195nz/MCZUjR0+8ieDN11Tdq/hBhA4lsSUNF3LmEQPwnKYjvMPj5l
	dw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 54K3atRt2136156; Tue, 20 May 2025 12:36:56 +0900
X-Iguazu-Qid: 2rWh5b6vHKqjzwDKO9
X-Iguazu-QSIG: v=2; s=0; t=1747712215; q=2rWh5b6vHKqjzwDKO9; m=7AcEo5X08lUtHRpT2gbD0oLk2zbgnCFPyKCiIloGarc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 54K3ases2345002
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 12:36:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwPFHhaUzGnmyLZa9F7WnUo4Tcf9SDPZ/cFZkFIMkWISzX00JAWuCzzlQmHayhvWHNKNi7Roc/VCSnjqDTfEPVPc/OIPFiX/cKl61GzUEngPkUJdw0e4J4cd/4Fp0HoKA2i8spjmtt1EyxQybpRkdk/LQIcOhZmMh6OsF0xWl8LFnzJCH41Q7bG70u3VrWeKQWFo8BApFeA0pyiyAp0Y5AqBBYKhAkXT33il8hisq3amJBLOdC4wgxyVLYcKS3ofPhBIqLWS8CBt/h3YIRutMOXMkjEECBwEJC3FGIjw23PvzxvVW+WK9+QXcZ0bl1fD9IDOoTQBtOUshFRaqJzhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APD0eRYl5A6a7ppi36TS33DiCmmb7xIzgQcuzUIDpKo=;
 b=oMCqwbdVtY5xe5/TvO4rXMT5NaHnBlGqgWfmVIOlPXFLf0ItwnvGRhCsoC/3GMYifORctFc/4l7JrB9UjCsIPu/xEq3azlL6T3GaBea9xyXOpTf2NMEAeiqt5JjgIIw7zHNXjIn9//ognYBbVg2GGE9tJDthoK1aabmkOKrkwdMZXvAj9JlSoE9KVHst2tT4PoTLl5jBHYk4zNrVDnuEU4eeJHXdm287WRJeRHbuVr5OZR3csr8UAA3zrI7OgenJo/hUaWkIE1kX6DaonF0wXVBWnwscXP2opRqtaNefioOLziz6JF2uZMkzyMiZCRTA+S4qy3cXjxPsX1ORr1Qplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.29-cip1 / First release of the CIP 6.12.y
 Linux kernel
Thread-Topic: [ANNOUNCE] Release v6.12.29-cip1 / First release of the CIP
 6.12.y Linux kernel
Thread-Index: AdvJOE2f+wKzQrwMR0GTmlYw6VU0Jg==
Date: Tue, 20 May 2025 03:36:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189E1415279A9EA59C583A929FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSYPR01MB5431:EE_
x-ms-office365-filtering-correlation-id: ed06da68-ba1c-493a-0081-08dd974f8d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SXlUeE5CWncwY1BZQzVDSDdBZDRzVGRWNVA4andIOVVmMlBhbTEzTi92?=
 =?iso-2022-jp?B?ZGlaLzZxVktsN0lxUHlwRDJmWHlkamhnT0svUkZzS1BydEZmT09ucURZ?=
 =?iso-2022-jp?B?VWY2Q2Rocjdxci9qa1B5SUF3VkZSVEJ4SnVWUXZEenBlOGxoUTFoc3RC?=
 =?iso-2022-jp?B?M3hKQ01YQ21HMnh6NFJ5ajRLZisyUzNyOTQ2KzNPS3ZRa0JNOSt0amNK?=
 =?iso-2022-jp?B?QzE4RGxTS1NERW5FcFJETEF3ZDFVY05STldiOFByQ2ZQbkJhOFk4bHM2?=
 =?iso-2022-jp?B?WTZ2UkcvKzJOQkJpZGs3SEpKdS9zbTB1Y2UzcmdrNXBKOTRabE5lKzZU?=
 =?iso-2022-jp?B?N2NyeHA3T015UUJldHNhbjNjR2pQZkdzeTFpVHh6L0pqT0NqOGtxT1pI?=
 =?iso-2022-jp?B?akxZNlJIcXNQMVJNdTRsTHl3Y1BEMDQ4TExRRjRsQmlEVXpUaXpFZVFO?=
 =?iso-2022-jp?B?UUVYaVNZYnd6MVk3WWZRN1lSWE1Xa2RDN09NWVd6dzBrR0hlZzh3UEpw?=
 =?iso-2022-jp?B?UkJOV0J6M1BlNzlVWG5GTC9oZDVtcmxpTVFTT2tVMEIxN2xVU0lmMURB?=
 =?iso-2022-jp?B?WndyQURxZFBPTXNnRi9DWGwxeWJiaEFRakh1UlYwcHZ5MXp4MVEvVzNE?=
 =?iso-2022-jp?B?bk5zMG9SVkxxeW04Vk9OZlVvZ3ZXRzlkWHMwREZXc2ppTzllS2F6OGt0?=
 =?iso-2022-jp?B?RXZGNHZOMlpqMExyQ1JjZmtLb29pSUZDd2Vvb3Fvelp5WGdrYVZxUnJp?=
 =?iso-2022-jp?B?OWxJV2c3V214cEJlb1JxU2VmSGZkSHRxRjVLTjgybE1FS3F2UjdUb3NL?=
 =?iso-2022-jp?B?VzZCSkdHVHRHQjUxOTZmSzVUL0s4YU9SQ29YNzhrQzBxY2Z5TGhkaC93?=
 =?iso-2022-jp?B?aDJNZEdjZFJodSs4ZkVsemNReW9CRjU0ajRPUURXdkUxSmpNTTh0YXQ0?=
 =?iso-2022-jp?B?NmtUemtkcnRKSlBCZVdhZkVkVW16cTBmdFpBTG5xb0UzY2RkWUtRWUFL?=
 =?iso-2022-jp?B?aDV1OHFTZkFDZHV2ZCthZnljb2tTZ2JqK2pCbVMxYkExUkdsWGJ5bHEv?=
 =?iso-2022-jp?B?c09ScUZZUHE0aFdOcEZvVUg0NWtRMFJpcDl6amp5S3dxK1czb3F4Zjc2?=
 =?iso-2022-jp?B?blpRZGhGMTYxNjUxdXdQWGhGTytaVlcvQkZRcEloUGhEU29uVHZ3by8y?=
 =?iso-2022-jp?B?Uk9Hdmh3dVpwczc0ZFNwWFhKd2ppZjBYQVRXRmxidFk0dGIvelU4SGwv?=
 =?iso-2022-jp?B?ZlA0ZC9ud0dhZ0pOSkJ4Vk0ramIxdXpEWnBNbUFpd04xY1hsRWtKZW8z?=
 =?iso-2022-jp?B?SnZaeVFVdlZnNjQvQ0traU41UmN6eVV1U1pSa3JjeGEyL1JDTFNaWGY2?=
 =?iso-2022-jp?B?bitUdU5GTjVFeHRwSGxRenpkOGtuZFZuYitJVEFQbXZZeGRvWDNwZmdk?=
 =?iso-2022-jp?B?eGZielYxY2FlSkVkb3lLVTREa1ZHbzFZR3hkUzJqWS9NNEdqRXhVdGlJ?=
 =?iso-2022-jp?B?UDIyNDhaRGF0K01BYU5KaS8vU1hyQ1l0VkdEak9iRGQwSWVZWHA5RExm?=
 =?iso-2022-jp?B?YzV2U1JjOUJxL0FqSWV5UVlLT3hIblhiZTVxL1hvS0NmNlNTam9CVk45?=
 =?iso-2022-jp?B?djgyczJncGhlUVlWZHpFRjI2QVVMMExackxUSTVmY2s1WjhEYWlNUlBD?=
 =?iso-2022-jp?B?eDRCZzJBaFRVZGNuUVVLbUN5VUxxRkszRXA2c1ZKMzJ1emJrL2FhZzVJ?=
 =?iso-2022-jp?B?ZXhPcVpLdWR5WGpZL2h3bUU3SXo4ZWpBQ0ZxKzJITmt0TE9CbUcrYUx4?=
 =?iso-2022-jp?B?T3M1WVBXMklHaGplMmd6Z2ZHMWdHeDBiM0orNnoxZGtrKzNsNDVsMm1X?=
 =?iso-2022-jp?B?YW8xZmZZUmZMbnZGeEFXRG5Id3Q2Q0J6UzhGdStadDUxWEFMdk1qZyt2?=
 =?iso-2022-jp?B?WVV2S01CMDlWdkw0VTExZEtZK3RKTzgwR0JEV2pUQnpNVDh2UnJtU0pm?=
 =?iso-2022-jp?B?RWljcnBxc3lLRW1YN05ZOG5QMWxLWWtlemZaRVBIV0VtNnNSQ25WaW51?=
 =?iso-2022-jp?B?bXN4VnNFbXFIS1l1VGxUalRqbmVuY2c9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y0toN2dwTk5YNzlIT0RvbGUxbnFwVkIwaFBiS0F6WTM0VGlZVFR6RHJG?=
 =?iso-2022-jp?B?dnJhMGZYMnpMV0o2VURFWjRDdU9LUnBFeldhMzZRVWlYdUM1QW9EMUxk?=
 =?iso-2022-jp?B?L2s1Y3BTNUU4cFBuSVBmL1pyNzREa2JCKy9BSzhwUE1VUkFnNis4UXo3?=
 =?iso-2022-jp?B?YnR0QUdmUmNRT1AxRUpYakp3VE55YXBlWisxdmhmcVdnNmFlc3BpUWt5?=
 =?iso-2022-jp?B?dTRweHZiaHpxRHU5Zk5GV2V3M3prMXRHUlUrTER0RmZWU0o5eDY0THAv?=
 =?iso-2022-jp?B?djA2MTBUM0JIRGhXaC9xOFlFRzJuY3lXT3hCODlHdW1MWUo4Zmp5RkJX?=
 =?iso-2022-jp?B?RkpWK0JFcFN6cDI0blo0ZFplUTMvdHFZT01tZEl4Vkp4Rm9IeTlsZlVk?=
 =?iso-2022-jp?B?cUs1QUJXdEZSVi9sNjF2c1BTc2E1T214NDA2eDgwSGV3QmExdmlFc2Jz?=
 =?iso-2022-jp?B?Qk1rYkJGL1Yvdjc0RHk3TTFmOVo5S3ZvSlErVDRtcFZITE5kbEJScS9Z?=
 =?iso-2022-jp?B?ZHh2VWpoL1lVdFg3b2NLbThQM3paV2lEVVNoV0R3VlJ5Z09ONnJOMkVP?=
 =?iso-2022-jp?B?a2FPck9wVWVwQUtpUE44L2dqc2RSRnV0UUlYczd6WlZDQlQwY3ZZbksx?=
 =?iso-2022-jp?B?eFlJZTFoN00vc1duQmpMb1Jub3BnYkpmTWZYMS9ndXlFOWlUMEVqV1ph?=
 =?iso-2022-jp?B?Z0x4MWxRU24rWFR2dGxjU2VINTJTZkxWcXFRKzJqU3JMMUZpVGk5alpS?=
 =?iso-2022-jp?B?cElVNlBYanA5MDVkb0NUbDluNEJYLytWTFpTSmlMUjY4QmJzeURjR01W?=
 =?iso-2022-jp?B?UzNQb2p3STVNZUUzUVhZaC8wRjBFbURpRDRnNmZkRXZyS2plMWtpRmxE?=
 =?iso-2022-jp?B?OVNyUmFoZmZ5OWdMNWQvTXBTUU1XamRPTkhkTFI0K3I5MlBXMTBSQmxL?=
 =?iso-2022-jp?B?Z2xhVVRSZDF5T09adXI4TVd6dlRRSmNwT1pPa0dxcVBZbjBDWFpSLzRa?=
 =?iso-2022-jp?B?WlJnQWtoam5Nbmd1d09NVnFwUWNsSDFYTEthWi9JdmJJWGxoQWJFNEhC?=
 =?iso-2022-jp?B?Zi81UlllWU5DQ2VLdjJlVFRMenUwM01wVG50aHQxdmlNRGNiQXUyTkdw?=
 =?iso-2022-jp?B?UkhuV1FmdWFpOStqeW8vaTR3UkxlWnl2OExja01YTU5aL0tiWjBSVzYx?=
 =?iso-2022-jp?B?NUsyYW9ZTTZVZUk1L2JXZjcwMXNpMlRvbXZEZlVvdGhVYTdTRWVZampk?=
 =?iso-2022-jp?B?QVZmYVFkbkRKY0dkTEtLT1RyUDdJNjk0enhlQlVkcjd2cGlRZC9FMTNo?=
 =?iso-2022-jp?B?QzRJbVU4dGtiUXJaYzB1bE5CbGZjcnRDNlhxck1teHRXZ2tXTE9oTE5T?=
 =?iso-2022-jp?B?aW9ZeUgyQkloeWs5amg2Mkd1ZXNDblBxdUIrUlVRUkJxTlg0Ry9Yc2R1?=
 =?iso-2022-jp?B?VzJwUXBSZlE4NURvK05TNTk1Z3FxQ2hrQTNUV1M2RVM0VjFHSVhQL3hP?=
 =?iso-2022-jp?B?SDRkUFdWMElqSjB3Ymw3S0lSTnBVaTRsMG1yU0pPM1g1UnFReUVxN1I1?=
 =?iso-2022-jp?B?TWNON2QrYWpHZldwUmFTVCt3QUNJOENQYTEwVUxsS1RwZ0FwSXgvSzln?=
 =?iso-2022-jp?B?Y2s4L0tyeGZnK0d3cWExUWl4U2VtWjByMGt4YkprSEtOQzVGdmFDZ1pU?=
 =?iso-2022-jp?B?NGNyOHRCaWpqU1pKektqQ3UvRXVzK2VkTFEzR2NIQzY0cWRkRTd4UVhr?=
 =?iso-2022-jp?B?WnJocmRuWS96K0wxcWJGYTM4aUR6NnpaMHJJT3M2Wk0rd1BWczAwak5i?=
 =?iso-2022-jp?B?TDMwa1FkMmdVZEdiL0ltOEpMN3FmREVidVgxdlJyUlVNYzdxSDBUcVp0?=
 =?iso-2022-jp?B?dVR4Vm9QUkRXVE5BOG44NUNSeHlHVnFVTVZHdTc0UUFtaXNDYnFVT1Qv?=
 =?iso-2022-jp?B?SjdxK1NTeVhheFlGcXQyYldMUzdsRWFscjBhZDNPdDRxWkdnb3ZPdVBv?=
 =?iso-2022-jp?B?Z0ZzNDBDOVlRRW9BM0E3TVBBWmw1R21IQnFZVFNsd3FsNlF0eFk2Nzhy?=
 =?iso-2022-jp?B?MkgreXBuc3c4dnpncUg0cDdnb1pvdElGS2p4c2hkQ0ZORGdORFF1Ulpm?=
 =?iso-2022-jp?B?UzBidUl6dDVKM1BjNVpWWktVTDA5dS9CdkpYVmo4VmdjTzFONmQ3UjZK?=
 =?iso-2022-jp?B?TW9WK1p6cjBwYmYzNzRaUStudEJLczc5UXZIZkJVNWJFK3JnVkpvZjZC?=
 =?iso-2022-jp?B?MCtBeFAwKzlQNy9YSlYrR2UxbDNyYkM1SUFqTVUzUlowbXhUQjhNblhN?=
 =?iso-2022-jp?B?TUlVMTdJMjFNZGprcjZBNlNlWG81OUViQ3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed06da68-ba1c-493a-0081-08dd974f8d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 03:36:48.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J+8Uxm/cQ0i+cvxSYDeiay5xfYPY4l3CCpCZPFIA9DKBto3pKe5fUyn1l5AgZ3os++2GlEAWrx1CL02tDycbZ8LxE9i5RKCWS+HJ+eBGXh2CjkWKJG2aIDkX/0UXqgx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 03:37:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18923

Hi all,

CIP kernel team has released Linux kernel v6.12.29-cip1, which is the first=
 release of the CIP 6.12.y Linux kernel!
This is based on v6.12.29 with many additional updates for the Renesas ARM6=
4 SoC and reference boards.

You can get this release via the git tree at:

  v6.12.29-cip1:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      af4062852978b4a204076202d0ff1293987354b9
    fixed CVEs:
      None
    added commits:
      CIP: Add a number to the version suffix (-cip1)
      arm64: dts: renesas: rzg3s-smarc: Add sound card
      arm64: dts: renesas: rzg3s-smarc: Enable SSI3
      arm64: dts: renesas: Add da7212 audio codec node
      arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
      arm64: dts: renesas: r9a08g045: Add SSI nodes
      pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
      ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
      ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
      ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
      ASoC: renesas: rz-ssi: Add suspend to RAM support
      ASoC: renesas: rz-ssi: Issue software reset in hw_params API
      ASoC: renesas: rz-ssi: Add runtime PM support
      ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
      ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/s=
uspend the SSI
      ASoC: renesas: rz-ssi: Use goto label names that specify their action=
s
      ASoC: renesas: rz-ssi: Use temporary variable for struct device
      ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
      ASoC: renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_=
play()
      ASoC: renesas: rz-ssi: Remove the rz_ssi_get_dai() function
      ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
      ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
      clk: versaclock3: Add support for the 5L35023 variant
      dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock genera=
tor
      clk: versaclock3: Prepare for the addition of 5L35023 device
      clk: renesas: r9a08g045: Add clocks, resets and power domains support=
 for SSI
      ASoC: da7213: Extend support for the MCK in range [2, 50] MHz
      ASoC: da7213: Avoid setting PLL when closing audio stream
      ASoC: da7213: Add suspend to RAM support
      ASoC: da7213: Return directly the value of regcache_sync()
      i2c: riic: Add `riic_bus_barrier()` to check bus availability
      i2c: riic: Use predefined macro and simplify clock tick calculation
      i2c: riic: Mark riic_irqs array as const
      i2c: riic: Use GENMASK() macro for bitmask definitions
      i2c: riic: Use BIT macro consistently
      i2c: riic: Use local `dev` pointer in `dev_err_probe()`
      i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
      i2c: riic: Introduce a separate variable for IRQ
      arm64: dts: renesas: r9a09g057: Add OPP table
      arm64: dts: renesas: r9a09g057: Enable SYS node
      arm64: dts: renesas: r9a08g045: Enable SYS node
      soc: renesas: r9a09g057-sys: Add a callback to print SoC-specific ext=
ra features
      soc: renesas: rz-sysc: Move RZ/V2H SoC detection to the SYS driver
      soc: renesas: rz-sysc: Add support for RZ/G3E family
      soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
      soc: renesas: Add SYSC driver for Renesas RZ family
      clk: renesas: r9a09g057: Add clock and reset entries for GIC
      clk: renesas: r9a09g057: Add reset entry for SYS
      clk: renesas: r9a07g044: Add clock and reset entry for DRP-AI
      arm64: dts: renesas: r9a09g047: Add I2C nodes
      dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
      clk: renesas: r9a09g047: Add I2C clocks/resets
      arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
      arm64: dts: renesas: r9a09g047: Add pincontrol node
      pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
      pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
      pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell =
helper
      pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
      pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drai=
n outputs
      pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX
      dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open d=
rain properties
      dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
      dt-bindings: pinctrl: renesas: Add alpha-numerical port support for R=
Z/V2H
      arm64: defconfig: Enable R9A09G047 SoC
      soc: renesas: Add RZ/G3E (R9A09G047) config option
      arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK boa=
rd
      arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
      arm64: dts: renesas: r9a09g047: Add OPP table
      arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
      clk: renesas: r9a09g047: Add CA55 core clocks
      clk: renesas: rzv2h: Add support for RZ/G3E SoC
      clk: renesas: rzv2h: Add MSTOP support
      clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and rese=
ts
      clk: renesas: r9a09g057: Add clock and reset entries for ICU
      clk: renesas: r9a09g057: Add CA55 core clocks
      clk: renesas: rzv2h: Add selective Runtime PM support for clocks
      dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
      dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II E=
VK
      dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
      Add configuration for gitlab-ci.
      clk: renesas: vbattb: Add VBATTB clock driver
      serial: sh-sci: Increment the runtime usage counter for the earlycon =
device
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit
      serial: sh-sci: Move runtime PM enable to sci_probe_single()
      serial: sh-sci: Use plain struct copy in early_console_setup()
      dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
      net: ravb: Add VLAN checksum support
      net: ravb: Enable IPv6 TX checksum offload for GbEth
      net: ravb: Enable IPv6 RX checksum offloading for GbEth
      net: ravb: Simplify UDP TX checksum offload
      net: ravb: Disable IP header TX checksum offloading
      net: ravb: Simplify types in RX csum validation
      net: ravb: Combine if conditions in RX csum validation
      net: ravb: Drop IP protocol check from RX csum verification
      net: ravb: Disable IP header RX checksum offloading
      net: ravb: Factor out checksum offload enable bits
      arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
      arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
      arm64: dts: renesas: r9a08g045: Add RTC node
      arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
      arm64: dts: renesas: r9a08g045: Add VBATTB node
      rtc: renesas-rtca3: Fix compilation error on RISC-V
      rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S=
 SoC
      dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
      dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
      clk: Add devm_clk_hw_register_gate_parent_hw()
      arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table f=
or spi-nor flash
      arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash

Best regards,
  Nobuhiro


