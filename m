Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566AE7718B
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 09:09:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.125997.1734599358058995293
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 01:09:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=NoEUNuaN;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1734599356;x=1735808956;bh=1J
	xuymo5Zlu0R9uBtaryp4gvfulkRi8CuYG3tkwEFbA=;b=NoEUNuaNgrUT7wKpxKU2QvRxKUnxsDE8
	QY4wJpqxqvuPC/q4QUIoUGUSGaZNnSAHH7mGST58KnxG9poj6m5fvWw623lDBP53x2S1VfIy7Xg1o
	3+eAFFBDRxE6t3zfq8OQ5qryuLFGlCh66KmXboev/1x6GmDVdfhN6llb9KnPnWB9W+9LVuaVz6vt4
	faEePppJvLgudRfaGsUiwzwBFoTCM1olynop1GfmAIeA8dlS8ssl45yxAIyK4iwAvJzguj7g7Nlc0
	iL/Haps5R2jRLLiwKADqa07vhfXn4wL2CYKMmB9FOLNPiWtGKFlTM8A6vACvNoLsA0tL67wR94JmL
	TQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4BJ99GXg1033321; Thu, 19 Dec 2024 18:09:16 +0900
X-Iguazu-Qid: 2rWhqikybLYONSOnwM
X-Iguazu-QSIG: v=2; s=0; t=1734599355; q=2rWhqikybLYONSOnwM; m=ZEIXrdgHJn7Z5678MbsAGJiviqZWk4WbUPn8rTVOk4I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4BJ99Fm72404498
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 18:09:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekm3owNg9k3QgaFNTgs+FCpOdsiIW9Nj24Sbj215NFmvX+L2txTos77PtUyrL4kZVVIYnqrxELXWTWe5gaPYp8dvGBaChjHIoFRtfd2Um3xoaS/tDFSrkGT9IBIKKiap8nh+2PRiUJtvOZ4HlGAcrVN0k8GAoThX2P/cPy2EEa9Fyva5OPVMc/fCqQhBYzlkt2a0TY6ujkCq1X+mTzWqywdf7U/xkCAug/gAp/pqvREDQ/mJo5p4yPkl+l/UhN2YmbsmHz1xX2VLzUGZtjBTpdfNrN8GALN2tRMEx/jFJ0S8BdT1EulkI48oeV0HQlMQqOyrs1sPJexMbrfkiH/OIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htETTqUoVFxmJyKwja7GjMXjeP0SXKR0aAkcaoVXlSM=;
 b=a5ZNwVY1NR/1GLRpQvpfvlesHzbYsQ1v9nQS2lHIAlQOozFl0mMyCdnyU5XXaeZzLUJ/+QM45Df+2EOPh3NP/AC7xU8eW4enkLZ+lwllq0ql5tVFbiHCL8he8HFT9KMhOEcIwVBlKDqVJPlU5jwCdofVtmLrSiPR1+Ste8nSJxwWvzosoVFCyzHzgjyK32+ZhhjoOGGFFoc+b14GbGCEobxaofxZ2iPipPvxI1dnA+UBY7lspD5Ejo3gh8/epMo9lRchn1iaYV6emd9ZgCjDzjr9XMlMt2CTlTOXism6lm3gYxo/nnnpdi+7jNXn7HQaxe+fnLs+XXemkQQHJ7dRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat / 20241219
Thread-Topic: CIP IRC weekly meeting today on libera.chat / 20241219
Thread-Index: AdtR9SoexTUOBTfZRAmv/iKgDL7abg==
Date: Thu, 19 Dec 2024 09:09:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391EE99BC84D03BF2FC38A092062@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OSRPR01MB11646:EE_
x-ms-office365-filtering-correlation-id: 709cf352-8551-4170-ba09-08dd200ccecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SitmbXhIQzlaaXRDdHFiNW9pbDJNTEIzTkJGcVI2cW90WGVCVkFEOGhw?=
 =?iso-2022-jp?B?Q3BCNlhLYzRraElvUjczSU5qS1RNMWdCc0Q2bVVTL0NkcW5KV01HUnlD?=
 =?iso-2022-jp?B?UUgzcjJ6MVRyTzRVaDBOUEFMOFk3UEZnRVQvT2FjU25EZ0FURSt6RkY5?=
 =?iso-2022-jp?B?dGVSQ1VwRmdnU29IOXNkeGtRcWNkTEE4QzMzVFlxR3BiMjExMGowbjFp?=
 =?iso-2022-jp?B?WHcxS21MK0RMNFY2MjdnR2RWZUExS3lPMDNYVzFWb1QzU3kxeGN5M2l1?=
 =?iso-2022-jp?B?Yk11eVRLQ2hCLzlrVXluOHA4OG50N0hmNEVhZmtSbDlVK3NkSnBPSEZw?=
 =?iso-2022-jp?B?d09jcUt4MGg5N1FmenFEV3QwWk0vMzhXVHk2cFJPR2RKUkU1V0RtUnNS?=
 =?iso-2022-jp?B?TThtM3BBZ3FOL3cxUHM4WUw2TmJDWXlqd1BaeEJmRUhmMzQzaFRhZjZ3?=
 =?iso-2022-jp?B?TDFZWGxPRXk5Y0Zra2owYjZ6bnVWUkthbU9XM1FleE1jRjczcUFOMW5l?=
 =?iso-2022-jp?B?TWs4bGVuRHJYQjVXVnhOYXVLaEFsOEdrbDRCK2c2bU5jQ2xYZERPZ1lX?=
 =?iso-2022-jp?B?VDdFY1hZQy83clpzSWVtNWJYcE96RU9ES3BodDFHUFNPbnM4cG1CYmxL?=
 =?iso-2022-jp?B?M2UxbHF4MEhBUklFSXgwa1JvRVp1MjJTbWdJY2xLa0s2VzZWZzl5Rktj?=
 =?iso-2022-jp?B?UUZTQUlmTU55SU1tS0JWbFd0cVhDYy9nUjd4R3dpWE9nc0JjeGZBMHB3?=
 =?iso-2022-jp?B?Q0Z5VFU1YXZ3UnRWdzludTErVHZMeDNhaXBzSnF0V0ROZjFjRDNna1RE?=
 =?iso-2022-jp?B?UG5TeENvU0lEM0pkaVloZzViWkN1MFBZeklCME5LZVRHb3FyTlZ3emFP?=
 =?iso-2022-jp?B?SmowT3kxeWtNUFJ6YWNRM2xsM1hzRnhVTG16WFhRcVlFVmhBQ0FtMitx?=
 =?iso-2022-jp?B?T0wvWCtKRHc0dVJtTXAzSGJvVndJRXFoSWNwS2pYanhCUEwyN055WmQ1?=
 =?iso-2022-jp?B?M290a3Q4K3RpcjB3eU5KaE40MmwyMUxscEhKQ0Q3MVpvb003anMybnc4?=
 =?iso-2022-jp?B?R0VKNFA2S1ViUGowNCtpeWZ1S0RxZFQ1aTJKRklhcjZ4TTB6c3VEczNN?=
 =?iso-2022-jp?B?bVNKVG14ejQzRWhpOXVScklueEpGa0YzdU9BSDI3VHJ2dkloMlovNDMz?=
 =?iso-2022-jp?B?d1ZIOWluZ0h0dER2ck15L0l6U0srbzUyMTJuU2hQcXFIQjR2Z21BWTIx?=
 =?iso-2022-jp?B?U3NiazlLa24vblR5UWhMVkNsSGhQaGg1bE5ZRFZCTWdiV2hZOC8vUHd2?=
 =?iso-2022-jp?B?WnhraHpmazMxTkhKOHYyMDhmV1BUbStSdmJLN1dBemVoZjU2MU1IWDFI?=
 =?iso-2022-jp?B?RXhHWnc2Smo3c0cvaUtrdi9Oek1CdTVWd3VEQ0pqTnM3QkgvT3hNK3Aw?=
 =?iso-2022-jp?B?Rk9DYitqTFZ4cFp6Sk5yd2J6L0hEVFp6dXYxblVCSzRlMlpkVzIvWW92?=
 =?iso-2022-jp?B?dzFONHNwOUY4YjB4NjFtaURFcEdDVUZ4ckNGbXEwSDh3Q1VaNmRwWDNj?=
 =?iso-2022-jp?B?N3prTDAvOTcvREoxVXlDNkdoNHQ2a2loSVJYaE5hQzYvUkM0dGJVaTFW?=
 =?iso-2022-jp?B?MndXZXdLWGxnd3hDUURYdW42c28ra05ndi9UeHdiemZ5eG5KOG1OWVdr?=
 =?iso-2022-jp?B?c2V3TlU4Z1FuYXZIM3dlaTZjdHMwVVdrclZQbnY4L3hkcnNWS0FPVC9s?=
 =?iso-2022-jp?B?M0hSRml0SWxrVmFVVktLcmRESWVtVXNrNlVUVWZVR3haeUUvME11KzBl?=
 =?iso-2022-jp?B?cnQzQWdleG93Nnh2cU1yQkJxTnc4dUp4RWxqSEhCSE51cW5ZeDF0c3Qr?=
 =?iso-2022-jp?B?R2xOZnR5Yk0wK3IrWlF3eXpQellWSnNtczVndlkrSVZMSS9kV2NDUjN2?=
 =?iso-2022-jp?B?SWF4Zkh5Tm5lcm5DenZkZUpJNGsxRE5PcTQ2ZW91U1kvSTFMU1k5Vm1p?=
 =?iso-2022-jp?B?T2VkQThnZElFN20xNEZqa1dPaUlrR0tjb2R1VHNjREVlYlFwRmhPSnRG?=
 =?iso-2022-jp?B?SHBWWDlZVzNTUDdYUUd0cmdsVVdXM3M9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U1d5TDRHMlRjcTJGOUQ4SjE4dFdKbGd1SHFKS2dKa2FrWVlQQmVDanJv?=
 =?iso-2022-jp?B?czN3Mk5ZUEVCTkh1MVdld2UyaVZzWkVLSXZIdXROalI5M0h3RDRGMWE1?=
 =?iso-2022-jp?B?Yko1SDdqRlRPV3l4NlFuUkhuZUFuZFZPdkVUSVVubXZ4dWl3SkhESUxT?=
 =?iso-2022-jp?B?QnBqQ25RVFRWNzQyNWlvSm00MkNCbGc3Z1ZiUFdrMjd4RUFnQWdyU2lR?=
 =?iso-2022-jp?B?bHdLQ2ZsV2RTU1QyMG10Y2EreThnOHdNVG56UDFIdnNrWWNBdGdhVXNB?=
 =?iso-2022-jp?B?Zi9zNGtxOTBzLzRlTVlDeWl5Y21La0xwcFJrVlpVOEJNdkczcEZveHR5?=
 =?iso-2022-jp?B?bEJPQ05DdVRBaldvZitla0YyZ2xkR3JOZEV6cUNYenlHZmlWcjdUOFlT?=
 =?iso-2022-jp?B?VUhRSVNCVVF3RTBralJvOFFuS21selgvSWxVOFhtMUVLYkN5TFQ3eVl0?=
 =?iso-2022-jp?B?d0R1cGlaallFKzAvNXh2aXBsV1lwT3FtS2Uxc2J5STBrTWxzUk9teU5R?=
 =?iso-2022-jp?B?cTBRUktyMWYwaU1SbVF0Zmkxc2dHNXlONXZwWVJFYUg0Q3J6SFNPWXRh?=
 =?iso-2022-jp?B?eE84NTBZc0FiSE1NNGpmaXBtTnNTTGNkdGxYNjVLWmIyd01zVGV4Qzgr?=
 =?iso-2022-jp?B?d1lTMzhDRjY1OU5IejB2L0xHOGhzb1RrczN3UHRYTWRVRnQvMzhQVkJ0?=
 =?iso-2022-jp?B?QlErMGhPYVg1WndkcE00YTdrMXRYQ1dxY0RPbFNHZmtQSkZVTVVabWVy?=
 =?iso-2022-jp?B?VWFvTlVNS1VHaEpXTlc2MDljdnFuRmRhcXdvdUhUS1pkb3JvYUQwUmgz?=
 =?iso-2022-jp?B?dlhHc0ZkTXpES1drZCtjamhYd0lHSWJGaHNjYXlQOEE2RjJYTURsUDNJ?=
 =?iso-2022-jp?B?Q3paeFBiakNkSk1sL2tnUEUxaFNueUhMVnhvQWZEY01uZDVmdnpTTDZv?=
 =?iso-2022-jp?B?R2M1V1AyamxoeXAyZW9DK3BPVUh5djB4Q244QUljKzBueTZpT0xMV2k1?=
 =?iso-2022-jp?B?ZWx3UlB4YURVWWZUZ2ovYXN5K3JTbS9lSWFpL3RiT1F5eklvbDB2ekFt?=
 =?iso-2022-jp?B?RXpEVXovQnVZcWJPUnpiZE5Vck0ycmRVUFNwellidGExMVJPUi9EdW16?=
 =?iso-2022-jp?B?NUMvdUJnMzJ4YS9pQVpqQ3ZPWTdON0ozMUZBcWFrSm1tMFJSOHpQcFFY?=
 =?iso-2022-jp?B?VWJsOEE4cW9aMW93clk4YXVzM24rWThQUGVDVm04SlI0eU8rcnBFbGIz?=
 =?iso-2022-jp?B?TllYMVNjVlZ6ekdaaWhRNWdoQlBPWXNsMzYvRGwzQVhMVmNZMnhvUXha?=
 =?iso-2022-jp?B?Vll1MCt2cGtrQmExeVVEOURKeFdHYlU1d3hXM0ozU1RXSmlsMnhGQll3?=
 =?iso-2022-jp?B?WWg4NEV5QW94QlVVc29kb2pXejhWY3B0T3Znelo4RVlIYXRYOTMvUU45?=
 =?iso-2022-jp?B?TExla0VvY0NzSWFXSG5sTU9KanM1UkhFdkpIL0hzOWlmUXZTV28rNXVF?=
 =?iso-2022-jp?B?VEhXSDYzSk96UXBpNjRLOVpOUmJ1VjFnREl4U2NIbWpXVzRtZG0rV0pj?=
 =?iso-2022-jp?B?UjNzRnd0Q2F3cWdLUTlza3ZZb2IwZEorWFZFbUk1dW9TKzdaRlVGUkJ4?=
 =?iso-2022-jp?B?K2Q0NGhFVXNIL1RPNTNZTmE3WFIyNU00andIK2tjbmZ2bnNwYTd1YkFH?=
 =?iso-2022-jp?B?TWNoMVhBbXpUbVQ5WGlyWmV3MzNienUrb3l3aE51S3dMNDJ5aWVPVVpZ?=
 =?iso-2022-jp?B?VUVScnRUNGQ1UUFQbU9acUtrRmdjbHNnUGRYN3N2YnB0OGZOQS9rZStv?=
 =?iso-2022-jp?B?b3lHMmw2UFBGR050bnZia3ZIdDcwTEE5UWNXemFyNHZqbG5HeGJRZGJu?=
 =?iso-2022-jp?B?NlBnQ0hjbDVGWG1HWnd0U2FtTUZLUllrdDRQR0FObkM2M3ZlVG1oUmpN?=
 =?iso-2022-jp?B?emVENUdrSGtFYXRsNzZHOU1HbXIyaVZPZ2JBU255blVhRnVrSjRtSHF1?=
 =?iso-2022-jp?B?SHFMOTczT0NvUE95eUZybTlzeXZ6d2FKS3hwdnRWQWdaZER5cjI0R3pi?=
 =?iso-2022-jp?B?aWg3UlhoYUdNb1FOVGZBQlo2MkVLQVRET096N0M5ZTVSV05lNS9FeENa?=
 =?iso-2022-jp?B?WWVLODF6ZEdUeGlmbGVGdlk3Rm8rNUVaTkZYaDk2aVZEWU1TVHhyQ0dR?=
 =?iso-2022-jp?B?SkpoSEZUYXQ1VWtIQXgySWxGcFpXNWhhc1FqWVJ4L0d2ODdjT2dWM1pX?=
 =?iso-2022-jp?B?LzNRendtRysremErbWJwKzArUmxrcU9ZdTg5NFh4bFRYbmoxYzF1Z2FS?=
 =?iso-2022-jp?B?TDYxOHBub3B5d0ZLRXkrZm5KUGNiWWgrOUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709cf352-8551-4170-ba09-08dd200ccecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 09:09:13.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dywlfJNWTwx0alsXbPNkZlVIXOtw3Qvmj/Nhhj/188+z7wenn1Fj9ZnsHVhm2K/EwoFDFaU9O14h1zcSF+WaFMq7NfyXvCcnzoAn048Fou/eqbxAG0B8pK/WsTefdwLK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11646
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 09:09:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17475

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mont=
h=3D12&day=3D12&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/12/cip.2024-12-12-1=
3.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
  - all green
* Kernel testing
* AOB

Best regards,
  Nobuhiro

[*]
Date the data is created: Thu Dec 19 09:05:47 AM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip94
  latest version release date: Thu Dec  5 05:21:08 AM UTC 2024
  limit date: Sat Jan  4 05:21:08 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip94-rt52
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.324-cip115
  latest version release date: Sat Dec  7 07:05:01 PM UTC 2024
  limit date: Mon Jan  6 07:05:01 PM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.324-cip115-rt39
  latest version release date: Mon Dec  9 12:30:02 PM UTC 2024
  limit date: Fri Feb  7 12:30:02 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.230-cip55
  latest version release date: Wed Dec 11 05:28:57 AM UTC 2024
  limit date: Fri Jan 10 05:28:57 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.229-cip54-rt23
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version: v6.1.119-cip33
  latest version release date: Wed Dec 11 01:47:08 AM UTC 2024
  limit date: Thu Dec 26 01:47:08 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version: v6.1.119-cip33-rt18
  latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
  limit date: Sat Jan 11 10:20:12 AM UTC 2025
  Status: On track


