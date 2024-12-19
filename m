Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB110E77188
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 01:05:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.120082.1734570315129803393
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 17:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=OZsSmI+/;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1734570308;x=1735779908;bh=5nLYqvfz2R69t9aRdIRrObI6/5L3ZaJilFCQVFV
	mSLQ=;b=OZsSmI+/rpu33uLq/NvQeCJVFFPs5P37mTDHn/ivfP1EGwu7H/HBO3ZkDLEL5xWS05PgJ
	vSdsK493qK5eA/r303J+4ueUyWvNoVgBuF3rOWcdjJMPSQcA908Br0ZTxAgphplvUU/MOZFjbdZx2
	R7dEjWvh7nJ7gb7x0L3yu7wpBxtoakrQQuczdEsXU2mHKsSkz60OxTJ2DttsaI2wdQ4Nkkm0mAEaK
	SAnakJ21Tk39KIWhPNFwEZcP3YdooUmOfNM0CC+HOcGjvZXiulV5ODOVvHXNsLtTHV6Vk9IyjdH3F
	E54y0Xbp8/wz844kLPF0LOgtVYoL6MIKhHhXsoIdEg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4BJ158Cf4173520; Thu, 19 Dec 2024 10:05:08 +0900
X-Iguazu-Qid: 2yAbaKzOeNLV2A7ZbN
X-Iguazu-QSIG: v=2; s=0; t=1734570308; q=2yAbaKzOeNLV2A7ZbN; m=0Px2thix+YftTEn9gNg9pmU2MuHzrgA6KspJDU/71os=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4BJ157xp2200339
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:05:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RH9i+dAwMlHpa7dF7/il/DIar9Hd9MzFZ7C38thbmd/6BNhYxKGy4AQTSm44k0DIs8t5GYu/Mrc5i86/MyWMTJLB9RJdoSj9t3VwVMl0Jy+CVZ3qGdIviqRvd+zcc2ZzhfXq4EDY+Gm2ZBPjS1JXloDs1bEIGo6pshDWZn/oeuFyRTSnfnIZAT0IYz8wRxtVf8tR2sSyJ7D4U92uOJ2W/ugRTO+GecI3q0BlLbVgamhJPHDYcrgjM6fy5mm1rssGxVFSJA6Ocix7QAsV/tX67WDq3gdNPmc9Qim/WivDSRZt3H9l2g1XL7BgeohJz4mKLYOkxh0IAwPn67TPdMNiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onDb7kdcUyO4gAoCrqYEtDEcn6u/vLKXaeSVOGxgbx8=;
 b=id1zzbaelXowSso5BSo4OO3ZxczHs02EfSK3NWb6HjG2MiyAItDa8Cu1PFhfsfCB3ZvczREPXSPiHc7OelyVgy25I4ab/fB7lr0evqwocqbNkRAGy1R6YSgFkSWrJuDPuZPvhG6HvJJotYoxoLWv1LTid6yQ5J8MJOovCU+nK+w9bMt0WRGfgvPPhm3hlcSpnnZoECAJYHep9AW3V6wH6HLlOCmCzudwUImJmFI2v2T2RBESachIIXDJ7PyKXbbanxLa2/68vWLD9BItxqgjL284AAQkTtoanGOQZ2FCQatwUoexjy7Ab719ld05yIedK42xTjoNXtVClQT/5IDvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Thread-Topic: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Thread-Index: AQHbUUeVQulCtHxlSUqBqBWyLKb187LswWgA
Date: Thu, 19 Dec 2024 01:05:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63887B34A61DD27E9EF3693A92062@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB8192:EE_
x-ms-office365-filtering-correlation-id: da040773-ff71-45b2-f72c-08dd1fc92c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aGc5RzhVTmNBNXFmWlJwK05XRHcyME5nWHh6RWx6VFZ1WFAvZ0MzNUhF?=
 =?iso-2022-jp?B?YVJFeVRJOUNHN3R0YjdHZDhnVE5FNDZIWnY0eGE2bmhvTUNrNy9WTVQ2?=
 =?iso-2022-jp?B?S1Zuc3FrQmc5b25XQjQ2eDhVTEdpM2RGZFFGcEZFTGozd0hKNVQzcndY?=
 =?iso-2022-jp?B?aGxlWEpOaDNQWkRjZkF1ZitiRUkrc3FNY0ZuZ2RrTThZOGNFUHlxaktQ?=
 =?iso-2022-jp?B?a01NdmJyRlZId3NqMTUvN0pFRE13R1FnNDhlM2RTZzZMamtobWwyLzNK?=
 =?iso-2022-jp?B?VTNwalRaZGxIVnBDdExJaUFUeHpJRlVIK0tONXJJaEwxTU1oU0hUUGY4?=
 =?iso-2022-jp?B?SVZubG11NFltenZEdVdYa2dLNzhvS1dhakFUekM5ZXlCZFNMSUl3bUtB?=
 =?iso-2022-jp?B?WjBqNWp3a0RkQVk2ZXJuRUNnemc1bmFQb1J4ejBSU3dMS1FpUzFjT1Za?=
 =?iso-2022-jp?B?MnY1SUtpZVI4Y0FveFM3T3JuVG1NVGhHMzFWN0kwZWhkc2xTUWM2TnhJ?=
 =?iso-2022-jp?B?c1VkSy9KaHRRRm9sVjVYWndoVWhDNEthZU05ZlZoZG5zYnZKb1ZsWGVD?=
 =?iso-2022-jp?B?ekJZNTBMZDJwZDE0OXFsLzVyUXdjQVlHWUU3VmxlM0prZmNRS2dwakNq?=
 =?iso-2022-jp?B?NUNyYmdidFdYYjRMZ1hVM0dBZmNxV3VQeUQvLzF6WGNwankzd2ozOGsy?=
 =?iso-2022-jp?B?ZmdOb0NRTk5URkM0ZGV0dStmdzMrVWpzRmxBbm9yUGplMUVuQ0pHZ3Ix?=
 =?iso-2022-jp?B?bjNGMWVoaVJITys1UENHdmMwbjRQakFGSzhDd0QwNS9JSDVUZkkyVGFo?=
 =?iso-2022-jp?B?NE1wa1ljZnBTN2Q1dUJialNUejZZUWZXdGFpK05aVkQrZEVFcnhyVVY3?=
 =?iso-2022-jp?B?dStXQ3JMT1VEZEpvTDFZL2Q1MmxKZENnTVNkRWtmMEMwN0dKbDhDTTBY?=
 =?iso-2022-jp?B?Q2tEeXRheUpoV04zNFV6VG5qbjNlZkgwUU5xVDJweHd6cXJrelVZRnpD?=
 =?iso-2022-jp?B?dXNtUHYwcC9sbnpob0JOdHZHdzBOTkluangwT2FvWFY2QzhrMy9zL3ZQ?=
 =?iso-2022-jp?B?OHhPVUp6Q3llRXlnYTdzSkNjbisrQXJ2dWhxeGFNb2FvdFZRZE00U3hR?=
 =?iso-2022-jp?B?N1piM28vTW9Ga05LaG5wWkM4VzhSL25TT3FPd3BML3c2TUxIaFdjcVdk?=
 =?iso-2022-jp?B?SWhsSFd3K0VRbVQwNWVjUTBweGlnWCt3V3hRQ3NPTkxwelNlTlhtZDJl?=
 =?iso-2022-jp?B?MzFsWjFYRHIreWRHV3RqMm5Jc3B1MStVeUJ0SWtJY2VJUWlMVFNBbVgy?=
 =?iso-2022-jp?B?dUNlMDlqRmNFem1sUHMrOTNHR0UwZ0ZuY0VCWHRIUFZGYjJuTTRKUWcw?=
 =?iso-2022-jp?B?dFFiWXVWVUFOdHIyMHBrRCtEOGVXUGNkSGcxNHF0S0JnQ082YXFZR0oy?=
 =?iso-2022-jp?B?Yk13aVVQUmxZanhTaFBUSVAzNUF4V2J1RTI5ejBvaWg3V0lkUWxzblRF?=
 =?iso-2022-jp?B?OVNjM3VKb05GTi9OU2kzL0VYbkloWnU3cnFVRis1dWVVOGpxdkFMaFB2?=
 =?iso-2022-jp?B?TkJ4bUNvVXI5SmRtQlhZRGdwd09lSnd0MXFSdFpJQU8zS3Nvc3NQUEFJ?=
 =?iso-2022-jp?B?a0Z5cUUwNWI1c29Vck1uaGZOUC9uTlhRbDdEc3hzd0l5Y1crZytmaEIw?=
 =?iso-2022-jp?B?bjFqOS9sVkptV0xmeFZkQ2d6OWN1WndUbDhlNWxwUkpPZGZRT1NwZGpz?=
 =?iso-2022-jp?B?WG00SFcwRjRoZVBTSHRIMm9WT0VxTmtib3RTSFBlSVpnNXRpQ2xkS2U1?=
 =?iso-2022-jp?B?WENPajErUVdQRnBaNTlDMEpBWFFvZ2V2UjdDcE9rL0haamw4MTFDNk9p?=
 =?iso-2022-jp?B?MTEvZ293QnU0RFM1NTJ2NjdxTXQ0d2xhK3BKdExBWWF4OWFsWXZ3eEN3?=
 =?iso-2022-jp?B?ZXU1b244Z2J1ZjFPbFh5UjNGNXpsbCtJTTRDaVA5WjVETmozZDAyRVV0?=
 =?iso-2022-jp?B?UzJtZnBCdEhXZGpxb2cwUUR4Z2tLVHREejFoQnoxeW5KakQyRWhzcUI0?=
 =?iso-2022-jp?B?eDJyeFBvVW14Ly9XRFd3NFJTbnRCTmlsMWtrdktNQXQxSzZlM2hhT2gv?=
 =?iso-2022-jp?B?dkVRN0hMc1N1QjR3RUpZK3VONjhTK2RnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ODVrb1pZUWNlbjBXQm1CTUZCcysxR1NuMEpxU3Z6TTFxaHBYWG9rbytQ?=
 =?iso-2022-jp?B?VmpKM0JBUzloakg2am1IQ25qZnhtYTl3RDJZcXRWOHpOQUxKVzFRMEh1?=
 =?iso-2022-jp?B?ZzA5QWIxVDJLbitXVjdiRzdzeXlnWlNpMHdVbkttTEJ1VVh5Ui9QNDQ3?=
 =?iso-2022-jp?B?TjNUeEw3UFRGNjhDR29XV0RsRDhHdjNvcndZc3VxV2NUOGZ4LzlObTg4?=
 =?iso-2022-jp?B?ZC81bE5Ma0dkbDVNY29UQTNoblFsZ1FBZVFZSGs0R0drNVdGNkZmbzFh?=
 =?iso-2022-jp?B?VkY1cDZvWmcxNlZkMExNaC81RndZQ2wrT3NyZXZraC9HUmZnclR5dnJ4?=
 =?iso-2022-jp?B?YkJmRXUvbEFQU2phbmxibHJlQ1J2YnduS1NRSGxIR3pPa1puQ3BmVTVt?=
 =?iso-2022-jp?B?K25obldsL3NZazlQbmUwUitVS2FzV041eFgwVDhxVTN0RTkvRW1vT1Rl?=
 =?iso-2022-jp?B?d2N0SlVjc1FMU0c5ZFlwdmM2N0tTVmd5NkpNY1Qzd2pHYnQwdEs0RS9D?=
 =?iso-2022-jp?B?bzNIamVnYzlHZmFwNjRNc3FHZWlNZ3laaURKK0pHa2M3OFZVM1NvTDJo?=
 =?iso-2022-jp?B?dWhtNy9JRWErRWIvQ0EzeGJINnU4c3M0OEtNVDRIS1lTZ0RHNG5QSzlE?=
 =?iso-2022-jp?B?UWlrcGtSYVpZOXYxM1dQeldvb0doRG1vQU90QmN6endKU0wvRi9KcWN6?=
 =?iso-2022-jp?B?OVdNQ3BQc0RyUUtkNUVjNXNoVlUwMlhZa3FXSVREcHUrQmx5OHZFRkU3?=
 =?iso-2022-jp?B?c2dBeGpkNkZLTVlwWDlXa2NqY3dQRXFydzQ3SlNVazZucXlRNkxSbUNZ?=
 =?iso-2022-jp?B?bXFuNWRMdlpNbmVoNnIzK3hsZEIzTStoWjdzRW1CM3JEc3orby8welMw?=
 =?iso-2022-jp?B?SDN4dEQ5VjEyZFVxdWVJY2VWYjNKWHFDZzcvQ0tzVS9DSnBKb05hWGNk?=
 =?iso-2022-jp?B?U1FzTmJ2S1RHU1Fycmk1dlRkeXgwazU5ZmR5dFVtcEdhRHlzbXZwcnFj?=
 =?iso-2022-jp?B?QUpKNHQ5aTE2NUI0NE1PdTFyQndDRGR4S3laeVptN2h5TktxV2RKS2FG?=
 =?iso-2022-jp?B?WDZGZisvOWdBRmtZKzYwUUxmQ3FjRFBpUS9KVm1yYkEwTHBxcTZZVlE0?=
 =?iso-2022-jp?B?UExpdk5Qa0tLckc5Q2wvWmJ1cDRMUEpyQzFvVC9QVnU3UXJzb3k3NkU4?=
 =?iso-2022-jp?B?S2pYZ2lDQ0FPVXhrR094SkdyK25jYkVwU0psWUEwSk52V3VuNkhmaVEz?=
 =?iso-2022-jp?B?aUNlS3hPNmtzZmFJYXRaVnBnM3ZUZUkyRmsraWpwRWF0RFZGcktZUTY0?=
 =?iso-2022-jp?B?cDdtNTU0THl4cDNvNzN2NG9aVEN2c3FzbWJBL2lpeVB6a1BJbndHd0xy?=
 =?iso-2022-jp?B?Y2ltWTE1YjNPSVRSSkpuUzI4a2hXWDMxbms4M1ZmVlFJaEROYU1uMHI5?=
 =?iso-2022-jp?B?cEJpZGwyVFFha2dQYzZpRWZrVTNJTGxHSnhMUzdlZTBsUkx3WC9xeXVM?=
 =?iso-2022-jp?B?dENhWTFEK2hLdjdiaGZ5dmp2NlFkVU1nNTR3dnd2WVliVnFGREJsMWZr?=
 =?iso-2022-jp?B?UVpRTjI0UmRuc1ZoWVJtUURFT0lLWEdrdjVWZE10Tnl3QkpuTmJtZ0lu?=
 =?iso-2022-jp?B?ZWpjTGsydlBQR3YwVVJtSGFVaExuZXMxWXFoL3NqblpKd3VLWlYrdVg4?=
 =?iso-2022-jp?B?QTEyaklOUWkreEFONDk0YW05bVZlbHpxUUxCTXBndmZkRHcyOTlLZmlv?=
 =?iso-2022-jp?B?UWQ5WkZmK3doSWRTTlg5TzgyM1pRbzE5ODJrR1lvdElRbFFMdkxDQWpp?=
 =?iso-2022-jp?B?cVMxVWxYRW0zT1N0OVR6QitKaDZsMHNMMnJpMjZja2Q2NXM4a0NGSllX?=
 =?iso-2022-jp?B?M01lUWVJL296RSs3aTg0ckl6RWxZR1NlZkJpU0tMRTJBeVBIdXZxNURp?=
 =?iso-2022-jp?B?RFhIMzhwZGhTRFFHYnBITitVNS9LdnlwdHRoSGh0TXlOWXNqOVJVdjk4?=
 =?iso-2022-jp?B?VDlBdlRGRFlUY2pNVWgwU2lXTzhsNzJNa2xBaC84SThsVmdST1hqdjYr?=
 =?iso-2022-jp?B?a2RFVWpab1FLR3JnRWgwYkVJeVRyZkh5SFZkY0xzRlF1Z3J6RXkraDh0?=
 =?iso-2022-jp?B?dWdGY2o4LzdvRWtWcFR3MlJXak5OeWE3ZmtlcitZS1NPVE5leThVS3Bu?=
 =?iso-2022-jp?B?aUpHN2hDaDRaa2lNdjhyZnNmdEMyVWJCZm8ybkhGZktMOTFiUUtqbk9M?=
 =?iso-2022-jp?B?OW1iN203ZnhMQm9mL3NUZUdlTmI1c2s5Y0g4OGU1dHJ0MDF1TXVPRkVM?=
 =?iso-2022-jp?B?NkdoanVSSjhLUjJQL1JGa0ZiL2lVUmNpd0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da040773-ff71-45b2-f72c-08dd1fc92c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 01:05:05.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tiIN1DRwafqhvzhK6d1K23mYviTx+DpzJbzCxr/tBMtrgXqV2oeNP37szaZAWkwRfK6wjHxeloBuC8Hg+ip5tDHuL8GxJEENoRG0B16ljq7IkzEL0OyIPN3O23dIgNQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 01:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17473

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, December 18, 2024 9:23 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org;
> biju.das.jz@bp.renesas.com; prabhakar.mahadev-lad.rj@bp.renesas.com
> Subject: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport
> RZ/G3S support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the watchdog support for the Renesas RZ/G3S SoC.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (8):
>   clk: renesas: r9a08g045: Add clock and reset support for watchdog
>   watchdog: rzg2l_wdt: Remove reset de-assert from probe
>   watchdog: rzg2l_wdt: Remove comparison with zero
>   watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
>   watchdog: rzg2l_wdt: Add suspend/resume support
>   watchdog: rzg2l_wdt: Power on the watchdog domain in the restart
>     handler
>   arm64: dts: renesas: r9a08g045: Add watchdog node
>   arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
>=20
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  14 +++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   5 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
>  drivers/watchdog/rzg2l_wdt.c                  | 111
> ++++++++++--------
>  4 files changed, 86 insertions(+), 47 deletions(-)
>=20

I reviewed this series, I had no part to point out.
I can apply this, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


