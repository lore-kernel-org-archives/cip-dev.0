Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A3CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 04:22:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10923.1762230145397708116
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 20:22:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5A44M4d7464671; Tue, 4 Nov 2025 13:22:04 +0900
X-Iguazu-Qid: 2yAbc3FhhzT41kS1dx
X-Iguazu-QSIG: v=2; s=0; t=1762230124; q=2yAbc3FhhzT41kS1dx; m=LU8xb+8yQ+h1+RrX8HhWD6TsJUpiWeJI8IGquexo53c=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d0wJq2mYQzyPZ; Tue,  4 Nov 2025 13:22:03 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJEhszrWm0qBmhY3wVGQsu0bt2zlAcaLPz6bQfnuuMrcbvAodFpAHoAiJBkoblKfPdboZPMCHTrxu1ZY/vkflm/pkeFoaf5hl4m8mNSPbF2VaCWR0XF1UbWpreP0Zee9URTX4KbmMhrw8b0Ih8pMVNGxfMfqW7dLZzcabGNMKTPKa7WHGccT8rsvvGRK7mtFjttEM1yFb9NeF8UdxOG3EHIkzvzpi/XZsxEvewgKTgPMGexaNhSIcKAKQpCSbuSGqkJcAJQ+SiiLfbOCkB9GWIBtNKGcPTyfvhY2+RVJQeD4Db3PurUR/iEsPOffK+62vDInYn3/dWesewyJe/cM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH8LUGyyFHM+DsKDKNGZ2ouyrqs0fNKufAQXk+V39dw=;
 b=YG6d+njXSaOiFSFo63CLmkHEtzM6U+MhxyXtdvhXPaYUX7jZjeG7KP+YEcUzb4mFYLbdWiUSTTKz1Rjqu4ytjSyBS2xJfBG6qdzfLODJsrscb4PMDBdzcW9bIG4x3oSuhB6FdALRG4zcgFoE15Dr6hUZvnh1Rqi5z8thK0vR/PH4HuXpJ231cy+3qeDnqSo8nBJt/hQSprZHN7AXrMmKFyUfPchUhHIb6NvP/zBdyjUVNLWu0pRuTQrZe+wtfR315YixmmhyN+FCBc6WRiBf4HlYaMRtwnL/lw0kq58f3wCuSuFHpbJ5Uk1wlGaVugx4FVLGEYJ0hFyyXlYBC3jiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <bage@debian.org>
CC: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <quirin.gylstorff@siemens.com>
Subject: Re: Update Swupdate for trixie to fix
 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485
Thread-Topic: Update Swupdate for trixie to fix
 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485
Thread-Index: AQHcR+QeeyA+WW4DgU2o9D9IeTCOVbTh9LJX
Date: Tue, 4 Nov 2025 04:22:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669B8AA4DBC4754B9677E91C4C4A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <24a1f7d4-d921-42f3-b429-83cd78e25159@siemens.com>
In-Reply-To: <24a1f7d4-d921-42f3-b429-83cd78e25159@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS9PR01MB15440:EE_
x-ms-office365-filtering-correlation-id: 79c64730-d0a9-454a-6dec-08de1b59b36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700021|8096899003|7053199007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b3pSZjdDci85U3dES0FjZHl6TEtLUEpVUXVKd3FJZUJVeWgzUTB4OUND?=
 =?iso-2022-jp?B?U2RyMmRMMG1YVkRQYnptcDRKUjZyL2daLzNRRUppN3ZaT3c1alJDaE1L?=
 =?iso-2022-jp?B?eTl6OXhlWnpNZURBVlAwb05VMGhkaVBvSGxqMGVVWXBOa09ZYWRHdWxk?=
 =?iso-2022-jp?B?VzBGVHYvM2Iya2J2UzM3QWZzd1R1L1RHellXSE83ZUI5ZmJUaXM0eEE4?=
 =?iso-2022-jp?B?V21BZFlSQUxTL1NmK1RlbEZFdmFuZUgxazRhQlZMR0YyN3R2bXRBYVdl?=
 =?iso-2022-jp?B?WDJZdzJkVFZkTzZkRFh5OWZDOHA1VUFSeHpBOEduaFFYK1R6bmJhRllw?=
 =?iso-2022-jp?B?SzVqM0kwT21EdnB1bGFYS1VKbmV1QnhDWmZFRDZWWFcyckJERWJHcTd2?=
 =?iso-2022-jp?B?M2pqM3E0MnpndzNWSmxubnpZNGZ0MUxLbmIzeVlna2cvKzk3M3JHRG1U?=
 =?iso-2022-jp?B?b05XOWV5YlVDc3VuOW9HTk9JOGNkWmY2MVRYMUkzTjRzMk04SlQwQXgy?=
 =?iso-2022-jp?B?YWovNzl2WklCNGx2eVlBaGdKL1FzamFSRUlVU21pNUE3ellycTVHTWR5?=
 =?iso-2022-jp?B?SDk5R1JMUHhNRXd1WDJtL3IwSWpjdzJoMEtqaWtXTXluRDhKMkxQOVRx?=
 =?iso-2022-jp?B?alROZndOSy9RcmdvQUp1aG8zaXllUkE4TDY0S2dJT3Z2bmFuM2doL3JL?=
 =?iso-2022-jp?B?OG9vOCtPWTNpOURucUJ6U1dwbmk4OUpGUzEzODh3K3pWcFR4Z25CN1pI?=
 =?iso-2022-jp?B?Mlc3WWdtTUZWWU9xOVJ0bUJSRUxkaFY2UjBxZG4xNTFqY0NWemFKVUFi?=
 =?iso-2022-jp?B?dWNheXZWK2RKSXRZS1FWR05jZjVtdjdxbzBpU2k5TndramJ3V09BUWJi?=
 =?iso-2022-jp?B?TVg4bGVVS0ZVK051U245bkhOdnd1d3UxT0FYMWxsT0FjaWZSY1lDeklP?=
 =?iso-2022-jp?B?dVJQNGtBaGc0VlFhdG04c2swWE16ajQyK1lUR29lMkxYVjIxd2o4dlFN?=
 =?iso-2022-jp?B?YkdKcWcycWs1Qm5JdDNHV005bTZRVmxrYkFIYnpIbkpIU0VKaXQ4T3RH?=
 =?iso-2022-jp?B?OEpIbFFEdVZhblFMQ1FpckxUSXBnbHRjYlNncFcxRDBvM2RDRXI5QnZQ?=
 =?iso-2022-jp?B?aERaZVFMMzFoNjIzZlF4R2ppWGZnT2toWk14R3RsZk55T2o5Z1F1M1pz?=
 =?iso-2022-jp?B?TXR1YVJIQXlCU21ZV0R5OG1kYUVWSVduUGNFODlyNzBHbUdUZitlNHlS?=
 =?iso-2022-jp?B?dHYwSXNzaTNaOXFYeE9nMjBoSHZkOC9nenpuVmdYV3drUS9wYzRVVGNZ?=
 =?iso-2022-jp?B?cXh4Y0pxbkxrYzh2YmNmbUpZZzIzcTd5amZDUmhhVG9HQk42WllzenFw?=
 =?iso-2022-jp?B?WlV0M01RSG1aZDhZbW4rV0hpcWlFQjJvSzUzdHVjY1B2cGdkTWVGRmZI?=
 =?iso-2022-jp?B?ZHRkV1V1OWFJVDR1Lzd6TGVtYzZEMHU3NlNuNWFWaU5jS3kxcHNLOUhV?=
 =?iso-2022-jp?B?WWJuWU1ZeExDOHZMdUdqQjVkeEFZaG9oQ2VmZDBOTGlQTjZjelRLMFhK?=
 =?iso-2022-jp?B?MURtMWpZRzhYc1BmSkV3Uk1vdnBtRDBMem1zTEcyT0J2VDEvVHhFYmE5?=
 =?iso-2022-jp?B?Q1YrZ05jZWEyaXNqYWFZbmNUZFJ5dTBzRmJ5TitRditUeW9DRHBOSzRa?=
 =?iso-2022-jp?B?UzZ6dWZ4cnp2SGYvQmtzUWFOMDYvL1RqVHB0QVBHdlJJZk5XL0dvY1dJ?=
 =?iso-2022-jp?B?cjk1SnNvWkZ6WlVSdW40UHlXNjBHQWtqUkxvNjZPRG01cDBXVzBmaWR2?=
 =?iso-2022-jp?B?QjRGSmw2UHdlRmNNa05Zdm1Fc0liWUdQL1ZnTGgwYThTcFQ0SXVVSVAv?=
 =?iso-2022-jp?B?TkI4bnBYNng5WnBqMFl3QUV2WUM0YlBCamxUbXpOdGpqMVp3emxzWlRZ?=
 =?iso-2022-jp?B?eXBuejVRVG93MGpWVVBiQVE4ZHNyaVVEaWVHZ0pQVlVkdEFsK2xTeEdx?=
 =?iso-2022-jp?B?cG50b204Sm5lQk1rSk85eTF1b2hKTmZNRmVmYjRaWXIwbDRhOE4rTHgw?=
 =?iso-2022-jp?B?SmdHVzNFWFFTeDh5cUMrWTcrUE4wSGk5alZCV09VY2ZabWY0OGg2NXlF?=
 =?iso-2022-jp?B?MDd5Tk5FSFd5Sld3TXJwQTRqYzh2TFVndzBMWmNoeWJlcWMyMVNxUGdV?=
 =?iso-2022-jp?B?ak9mU3JIZmhHbUlUeTJoOXUxTW52QWVMYUhYRm5WMFVKeUNSNDhLazMw?=
 =?iso-2022-jp?B?Yk1iR3VxcTFFNzk4WDMzaWVHLzRQU2YzZz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(8096899003)(7053199007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZDNIOE8wZkZ3TlhKbGlJM3VwdzA0di9jOEJtaXpRTUg4VHJBLzhRSjZM?=
 =?iso-2022-jp?B?WHdZM1lHbUlYRWhXT2FsZWpiVFRTT0FsMkNZYUNiYk1LbjN5eXlHN2Qz?=
 =?iso-2022-jp?B?OU5TbFpDYnl0b3Uyb1hVdTFFNWVqbThYZW9wVGJOSjlLT3c2NTVmV1Vo?=
 =?iso-2022-jp?B?dGJrOW90eHhSb2MwalRMOU9yNy82ejZ3ZjNNNWgvVUZPemdxd08vQWJN?=
 =?iso-2022-jp?B?OW54TjVpT3k3M0NoZDFoeUM4WWpScnhxYWVRQkR1UktOdXRBMTgzZ2N1?=
 =?iso-2022-jp?B?bVNPWjNUOHZXNFdHaXNPUHc2MzQva0hTMVVXUzlKMXVhOEp3bXlXRTFY?=
 =?iso-2022-jp?B?UXBBZi9uRjYrTTU3Um80N2JWNG42RHpzUjRUa2xWSUR6Tk1xV2FVc01y?=
 =?iso-2022-jp?B?dVh1bjRTeW1hemFqQncycG1qZDFPbVNTMTBFKzFRZEM1UzJheVZGNWRp?=
 =?iso-2022-jp?B?VUsxN2dhME11L0U3dlZKek9KZEZDQkUwUGpZaFBPZmVZcVdvUndtL3JG?=
 =?iso-2022-jp?B?azU5R1cyWUNBdXhjd1kzY0xjWmRiSkFZZjVINER4Ris2dytIajZVQkV2?=
 =?iso-2022-jp?B?MG16b0QwalJoZ2g1SEpjNmUvemtTb3MydVNBZDRSYkdFNkVaa1BjT3FD?=
 =?iso-2022-jp?B?YVFkTDA0V3B6OVZpeEVLdVdnRFNORUhhNmRjcitacGI3cGFKR1AzVGVR?=
 =?iso-2022-jp?B?bFBtU1dTclVsRnowK0JWSEt2YUNoL25WcklLTk9KMktVaUdQWWk1Skov?=
 =?iso-2022-jp?B?NVlMaEVWQ1dUQjBjZER6WDR6d0MxN01CR0lDeTBzQ3VQRzhtQVVsbGE1?=
 =?iso-2022-jp?B?Vm5neEdHVjZnN3ZDbndaRUd0ZXlWbWJXd3dUc2FSRG5KYUFrSytIT043?=
 =?iso-2022-jp?B?dldscHNZbURGbWVzOGFJeGsvNyt0RWt3eC9nV0dUVzdQMWJCQTJkTVhV?=
 =?iso-2022-jp?B?dnE1ZGtuMUpoN2JPVHpHa1NMTDRCNWNMY2x4dUdva0xnNWlVMjFYOVlU?=
 =?iso-2022-jp?B?eG5VbHlxc0I5SStydGpjTU1kWU4wSWdROVhTdWNuSTRUTkUxYUNVQmlk?=
 =?iso-2022-jp?B?ZVFOdHNhcXBnVXhIS01xQ1grSDJMbVVDSEVnM1JwcmFxZXNGWCtuWGtV?=
 =?iso-2022-jp?B?Y0tKRjFwUk1zRUpOdmdPR1Q5aVJCSmduZWxxVGVDRk9YNXU4WXBmaXFm?=
 =?iso-2022-jp?B?TVVCUVQ2cHVqcEhuUlQwa3hERnAzcC96aElHYzNOcWhtck1DcmlpcHMr?=
 =?iso-2022-jp?B?MnB3TzVUcE9PQlh4b1hJN0psdmUxdWxyb2NLWlhiTU51USs5SGwrd01V?=
 =?iso-2022-jp?B?Nnh5UkQzdmhzSnN2MmhlbVJ6aTJrZ1dZS2NBK1hnOTZackV4VUlFVFdV?=
 =?iso-2022-jp?B?SjFucTdFUmJEZ1ZVcXBTV3U5ZHhDM201aERaSVVzOURBQ1BwbWFlYUh6?=
 =?iso-2022-jp?B?NU1NNHBVc05lQjZ5YVVEeXcxalhrLzNCQXBaNUJIN01ScFFhcFNwZ1lo?=
 =?iso-2022-jp?B?WFlLeHB4dXFENzMxMExVRU52bmRQTHJSYWt5Z1k1VU1jSlkzSkJvR2Zi?=
 =?iso-2022-jp?B?c2djc2FiUkFOMWtEMVZ4MW5aTkx4WE9NeHZWeGxUVlNCS29EQWJKUWYv?=
 =?iso-2022-jp?B?RlJCcXl1V2svc0xJNTdPRXFjR3BVTzZ0TDFaVlh2NG1rS2JqYnVsVC9u?=
 =?iso-2022-jp?B?dzlPdldLcmhwVzlOM0U5cWhiUnpQck5SN05uQ0pXdllIUnZmR2JPdjl1?=
 =?iso-2022-jp?B?Z0tJdjYxb2syVDdCdnovT1dLQlg3Um5XNHZvdHcxbEgzUXBVTjZBZ3R3?=
 =?iso-2022-jp?B?dXNWUHdwL1NxS05IUjBoa1FJTk1tOUJRelNYaEZxcTV3ZExVQUduQnlJ?=
 =?iso-2022-jp?B?ZXQ3UWVEa3h3N0hJcVpUcUFienIreWhVbG9zVFJGd01WUGROS1VLL2Nr?=
 =?iso-2022-jp?B?RDE1MTR4YlYzWUVRRGpUTlh5VHJMblA3THB4WGQ1dEpUNVJvZ3NMTkRD?=
 =?iso-2022-jp?B?RWRRbURqZmE0WWtGc0F6RldNMHV5MFM5M0NmamtLNk5aa3E3ekhVeWo1?=
 =?iso-2022-jp?B?UThTNlJURFFvTzdCM2tWVmlkSEpuNUJTdE5TWXduM0FENHZBdGlLVUxh?=
 =?iso-2022-jp?B?WG84Ymt0MlBRVHBwRnpFSXNuQzNVd09GeHdzUGMrMjBGMGVQMGNRL2ta?=
 =?iso-2022-jp?B?ZlhBbzZwQTYwTmoyRjVDSHphUzAwUnBHT05WYzNPZzhGNk5DZkg0T1Bq?=
 =?iso-2022-jp?B?ZkFhOHpNd1NBWXVpd2llNVRRci9MSGRwK1BNK1o3b0JXdnFYZDVFMkhs?=
 =?iso-2022-jp?B?dzRKNFZ5UUFmKy9Kd0N6aGtMcmNWUW9yd3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669B8AA4DBC4754B9677E91C4C4ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c64730-d0a9-454a-6dec-08de1b59b36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:22:00.8760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ty48mL/3mPOCrdN2uqB29Wj6KXQGTWth+oyD1TgBYL2zRFJKy/zrv01bGOiD1mx9v9lsQe0WJK/NkOUWpxhEtkJGodZJYQXuTWOWQyCEmDENI2zqf9Rw8tbAx3BoFz+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15440
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 04:22:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20347

--_000_TYCPR01MB9669B8AA4DBC4754B9677E91C4C4ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Bastian,

Just a gentle ping. Any thoughts on possibly backporting the fix to trixie?

Thanks & Regards,
Adithya Balakumar
________________________________
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Sent: Tuesday, October 28, 2025 1:53 PM
To: Bastian Germann <bage@debian.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>; balakumar adithya(=1B$B#T#S#I#P=1B=
(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O#S#T=1B(B) <Adithya.Balakumar@toshiba-=
tsip.com>; cip-dev <cip-dev@lists.cip-project.org>
Subject: Update Swupdate for trixie to fix https://bugs.debian.org/cgi-bin/=
bugreport.cgi?bug=3D1118485

Hi bage,

Can we backport the fix for the SWUpdate bug
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1118485 to trixie?

I can create a debian/trixie branch merge request in salsa for it.

Best regards,

Quirin


--_000_TYCPR01MB9669B8AA4DBC4754B9677E91C4C4ATYCPR01MB9669jpnp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Bastian,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Just a gentle ping. Any thoughts on possibly backporting the fix to trixie?=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Adithya Balakumar</div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"></span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, October 28, 2025 1:53 PM<br>
<b>To:</b>&nbsp;Bastian Germann &lt;bage@debian.org&gt;<br>
<b>Cc:</b>&nbsp;Jan Kiszka &lt;jan.kiszka@siemens.com&gt;; balakumar adithy=
a(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O#S#T=1B(B) &lt;Adith=
ya.Balakumar@toshiba-tsip.com&gt;; cip-dev &lt;cip-dev@lists.cip-project.or=
g&gt;<br>
<b>Subject:</b>&nbsp;Update Swupdate for trixie to fix https://bugs.debian.=
org/cgi-bin/bugreport.cgi?bug=3D1118485
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi bage,<br>
<br>
Can we backport the fix for the SWUpdate bug<br>
<a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWAa7b57014-b0b2=
-5da3-2947-cf1bf560eda5" href=3D"https://bugs.debian.org/cgi-bin/bugreport.=
cgi?bug=3D1118485">https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1118=
485</a>&nbsp;to trixie?<br>
<br>
I can create a debian/trixie branch merge request in salsa for it.<br>
<br>
Best regards,<br>
<br>
Quirin<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669B8AA4DBC4754B9677E91C4C4ATYCPR01MB9669jpnp_--


