Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEB8C54F65
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 17:24:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.3341.1649144771040751471
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Apr 2022 00:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2357k1IZ028426;
 Tue, 5 Apr 2022 16:46:01 +0900
X-Iguazu-Qid: 2wHHpFsCmknTu74tnu
X-Iguazu-QSIG: v=2; s=0; t=1649144761; q=2wHHpFsCmknTu74tnu;
 m=GZF7/QISW5XtUEx5wvajF0aPEBglWCUHSncuc1KAxsQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 2357jxvd012945
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 5 Apr 2022 16:45:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gisWEZFjFGq5DL7USBNvjsKrf7y4B46Er9RLpGfo2Ii3Ugq3iHDdMXM5wyhdNvrswmShrW/7X85TFzBC9A6cyO5XurfBiIRg3k6qbgMHMP9eUtl68RJyBs5g0NWNWvdPbDZorG7M9qtg0zc1hJP7fY2sRjEmYfXp/O/92DBubE0jJ86aZf1eRu8K6Ibf9dSby18gUK2gG99SOB+nFCtcT9nu9xEBgneoBG0hEwa7MsbFf5BaEy2J84OYJg6l+EX7yVaJvbuPE6+c6PmNxChkztQnlnOMHdMs/3UwCB2WvkgZEg+q7yYRCi7JyQEN/lFHYJV5Paz1kQ/cQ3iH88DChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLdqE9lGS0o0Brq1RmNAs8Yx7WO9oOKSsaW5u/h9pMs=;
 b=lE16qI8foNDLW/DjqwLO1GaxIZoReh8sakut6uvkhSeqSICoCMmM/2OoqZ+bB3EXuachSH4xOPQlHohTYIuOTBX4VyYrOnDBsKURNUsVeTc1NFBbR85aas2qUG3w59fY4LcmnLiUgmMlKDOIE8sfiUfi0v2ugRJ0P31670CkZ4sg6ObiAXZeWyxPlDn4QKuqOs0VLITZ7Wn5xI6hYbkM/Y9TvnS1T11OfjrZy+TsCfgFdJX86nNXulq3nHU0QEiocQcvuqYSH2f6Tdp/zsi8j4L6p0fHsBO1OYqpYJffOaItTjQYl7IxTf7Ni+Iyvq44Rp/irQ4HP+EeaVlCUOG8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/29] Add RSPI/OSTM/WDT/TSU/OPP support to
 Renesas RZ/G2L SoC
Thread-Topic: [PATCH 5.10.y-cip 00/29] Add RSPI/OSTM/WDT/TSU/OPP support to
 Renesas RZ/G2L SoC
Thread-Index: AQHYSCCQRDAlwBuaHUGpIcp8LvfNmqzg5Kew
Date: Tue, 5 Apr 2022 07:45:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB6252C9162794F7FA3316653392E49@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00ae75d4-00a3-42db-e9e6-08da16d8524b
x-ms-traffictypediagnostic: OS3PR01MB6421:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB64215B065B76866D8D8DD81092E49@OS3PR01MB6421.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VXdq4TLX6nScPoC337GYInh9SKTa2kagOr3OQaTAIhrT2WMvXpINHqKfeiIe9HyequG5L0H/MyQUj4Y/3ucmJhvARAf4CI7+tHtuRtxb4aWcOgVPRZIGYITOy5V9WI0NPUrLQkNXFjMH/o7ZvTr+3DfuAqcSv72uCkLtvhq40jvZMxDgBr3F/WEwS7kE1d9v+wpgMYd3b/BYbeVGET7XkKhCt4Cqs0x1qk3Z2Mip0qSA1DrvraWF2TYR/hZsGaJxyhwLwbXFrwyIIn6qILHzwsvDbby4oVSJR2nD6zXGHkQ1ZQyaKd6GQN7k4yGmbjHujl0wg1LfUCVn8HkKpunRqIGcSoP8oPSvRpnyuga5niPrCdBTGvenONU7/EGZkD1trDtNtEFm5q698D8zhZCB+KuSLBT8wWSj4lUm2GMPOVbZpF7DY1NLDPpEXOArrtUEz7JV4mMmTWvxYwToWYHJU+nH85cIhkorXcQBFlKKe2BwApcWyhaDBE6nmR3BvQ5+eD+MDKBHr/KpRcZtoNuA6PavUyBVRe8twvs0yLtTHXiFELeNFVDJAPlwlhRUZxWq1cKOIxUIPyIN9fByhMQoUm/tETlCSf/CZmE21RmpV3V+bO2xGddetOBTLoKJEQkOBnlrt/UhHJLfeZN6nCvavY6mW85vGi521Dw9JS2NrZVxLM6njKji76Tp9ukOYl5x16tx1m+/KfBrId0Uqi419A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66476007)(122000001)(9686003)(4326008)(8676002)(52536014)(33656002)(7696005)(508600001)(66556008)(2906002)(86362001)(64756008)(66446008)(558084003)(66946007)(38100700002)(110136005)(5660300002)(26005)(316002)(8936002)(186003)(38070700005)(55016003)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VkowclBlZjNIS1BYL0kxV2I4b09JdmVIQVJnUTFOQVJMRUwrYjJQS21sTDJn?=
 =?utf-8?B?SnU4ZXpSdGxUNEowZXhGalJtelJPU3BwTmg3R2tSZi9uekdRVkhxVlFSclBq?=
 =?utf-8?B?MjMzWjdaUDV2TWRaTkw2cFR3OVI0VVVmcGRVRzJPTElPdUc2bUVsSjJQb2pM?=
 =?utf-8?B?L0RYWnBqTHBYc3NmaHhMKzFmaWtiNndhYnBaZ3ZxeWIwd3JOTlFoN2oySFJ4?=
 =?utf-8?B?RGNLd2NpK2pXS1ptWFQxUUo5TXBQM3pYS0svNUNzVDZEb200YXhSdFZRYjNy?=
 =?utf-8?B?YkYrNzFDOUlOa01UZ3BaanprQnh3NVVlMkFhQXJrTEtwRkRGVXFqcUJpM2lh?=
 =?utf-8?B?RWV5T0FZZjBuTTRmd0dsVmdyNFNXRnkyR3lib1gzMUE1eG5wTStONC9peUNx?=
 =?utf-8?B?b2hnZk5SOHVhTm1oMFF5eWhTY2F4MjRKOXRNNHdhMlhNVkJ3c1lZZEFORjRx?=
 =?utf-8?B?TjFyR09HOFVhNmJHNHVvbHdJaGpTVXpjU2Q0WnlZSWN3Q05BL3dRcXJPQi8x?=
 =?utf-8?B?aE1tSWFEU3VhaTBUOW11TUJmeXNGUW5JZ3lxMGQrdngya25aOE5EMmUxMkht?=
 =?utf-8?B?M0dOYk5PdHN4aGs0czJjenZBdmovcTg5YVBDV2NHUGd3VzVrYXU0cG9Zdks3?=
 =?utf-8?B?T1RYVkRQdlJOaC9wQnZlSGY1NVBrL2RLa0pVcFlPZVlPTUhsSnRBUzV0Nzhi?=
 =?utf-8?B?S1RmQ0k2a21yQ2VSUmNXa2V1Q1BsVzhRN3JSTWcvTzA0SzRycXVuYjBnUlNi?=
 =?utf-8?B?Z0Yra1FFS1ZlZDh2cE9pb3MwY2dPWTQzTmVua2IrdGF6a09MZlhoRjFhUnV1?=
 =?utf-8?B?TWZjeE1tditwdzZDNnd0eFBZS0lpS1ljTFY2c0ZubGljMVowc0VpVDhTNllx?=
 =?utf-8?B?VUJGQkxpbUhqQ05VZlZSVWNoQm9OMTBWaXJzUWVhaXkrc0IyeVlYVGxtRG90?=
 =?utf-8?B?ZU1rM2Z4b1VKdHd5YlJ3S3l5dWJxQnFqVmdEaWtrZ05UQXZXRFFMM3NKMkFl?=
 =?utf-8?B?TGxVRGxPcFlOUHo1bEdick9BOE1kVmNRWjVjeE1SZHZPTEdCRCs1bXRLbVlL?=
 =?utf-8?B?VmMvYUJlR09PVlRmTG84R0dXa3prTlRtRGJCd2ZLOHNHL3pRTEdYeUJOVnM4?=
 =?utf-8?B?RTQ0T2dSTEZkenJCek5DY28vSWpPWTdyTjl5VWhsRllFM1VzN2NoTEo4cnJV?=
 =?utf-8?B?WFM3dmxZTFh6ZHdiMk5XT2txMmwxZHk5TUNpeGtJMzlIVW83dk1NRjNWZDdi?=
 =?utf-8?B?c09VRWRWOW85QUVUWVpYbEZrQXo2RGtmM2tyZVpKOUpGM21iSlQyNEwxc1ZL?=
 =?utf-8?B?d0pNaTQ2M2xIUkVhM0t4NWhSUFJhOGRKN1NEUmUzNEdiSmJ0OURVZWJxMXhl?=
 =?utf-8?B?SGU2NzJOU3JyRHpHRUZMRXQxSHNnSnVsRm4zMUVBQ0ZWVmJiYy9SMVM4N21Y?=
 =?utf-8?B?bW04Y3hiQTg3alZMSDNZa2U3RUVkSHFRdHBzUDJmditXR3hrVHRpZGlKL3ZY?=
 =?utf-8?B?ZWhWRWZwZlhhSC91c2hWODg0VXVwdisyMm5GbHU0TEJMMUdmLzNCbUZSR2hK?=
 =?utf-8?B?UVFTRTFCaVBkbnh6NERjb29WMXpCSUZXREUwOVBvMTlEYVlJOE9GTUFPMWc5?=
 =?utf-8?B?aXl1QjFRN2hFRUJhOE1EY1dhakZqcE9HazRabXVCcGJYWThQeXZSc21ueGgr?=
 =?utf-8?B?anFpdmxsdjZCUkZYUnJXL3FPNzg3N1pUSDVleFlXT2RMUjRNcHJidElEdGV3?=
 =?utf-8?B?NGl1ZFJqQ3g1T3pRc1pscHIwTnNaT3RqRFpqbGoxK21iWXVFeW1TZitESUF6?=
 =?utf-8?B?QmxXVHZRTHo2aXVpUGsvS2V2b3RhL2tBTGh1Tk1XMGdHeEJCd3VYcnNLa1JY?=
 =?utf-8?B?MmVsdEJ4NWRxbUZoRXRlbCtjMU12UDVVaFBJa0o3WnVxN2YvWXVMb3Z5cU5Y?=
 =?utf-8?B?MzBSdVhCd1ZpaGRCV1E3cmZPU2E4MDdOa2d1ZDZSTTk0MWVaOTZXWGhPdXAy?=
 =?utf-8?B?KzRNSmhGU0ZXTStPeHArWWRtTjJ3SEl5MVhOM3h3eHpKNy9OWjRlalZ1QUVl?=
 =?utf-8?B?VzlWS1ovUTFHR0RlRDRJUERlRFJXWFRBeVRFbWhORTNuU3JqSnZ0YzBmcThh?=
 =?utf-8?B?UTdRb3cyUlRXWlRCR0RmOVZjaWRuZHYveHV6ZHVXM0lSZmZwSWFVL3lhMjFx?=
 =?utf-8?B?R0VndGRVeFBXZXJEbWY4MWo5QVVaek0vcDBnYmFrc0hGeXdTZUVCTkZZbG1Q?=
 =?utf-8?B?SVlyZTdIZ2lXOVBTT3dJc2hkdXpLOVhKYmpVWE5oNytIYjdpbmQxU2wxWktW?=
 =?utf-8?B?OTNHSWtORHRrSGFaNzM2T2xZSzJqY3lxeGtEMW1wcWdkcUFYa3pZTnZWY0w0?=
 =?utf-8?Q?FEymHRyQjDVvw6A56Sa6UuO98Z8cbPYZjdIHW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 00ae75d4-00a3-42db-e9e6-08da16d8524b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 07:45:57.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 r9WTJoSv+j+sg+G6hb94p8/qwTUsUvOnDViPT7iVF5uEwcj8Ic0xgkeyV/bandf4grz8etu5QFgJ41ZPBmfsANQD74X+gkbxVUptU5BrFQHNEe4s4FvCw5ZhBvAW5djA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6421
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Apr 2022 17:24:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7996

SGkgYWxsLA0KDQo+IA0KPiBIaSBBbGwsDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1
cHBvcnQgZm9yIGZvbGxvd2luZyB0byBSZW5lc2FzIFJaL1JHTCBTb0M6DQo+ICogUlNQSQ0KPiAq
IFdEVA0KPiAqIE9TVE0NCj4gKiBUU1UvT1BQL0lQQQ0KPiANCj4gQWxsIHRoZSBwYXRjaGVzIGhh
dmUgYmVlbiBjaGVycnktcGlja2VkIGZyb20gdjUuMTcgcmVsZWFzZS4NCg0KTG9va3MgZ29vZCB0
byBtZSB0aGlzIHNlcmllcy4NCkkgYXBwbGllZCB0byBMaW51eC01LjEwLnktY2lwIHRyZWUuDQoN
CkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


