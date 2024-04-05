Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F4C67861
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 07:40:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.5831.1712302800678033457
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Apr 2024 00:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4357dvgL1678837; Fri, 5 Apr 2024 16:39:57 +0900
X-Iguazu-Qid: 2yAaAnXleJatKx5nMf
X-Iguazu-QSIG: v=2; s=0; t=1712302796; q=2yAaAnXleJatKx5nMf; m=Wj5dAFiZer5GIPKCtaM75WNSI3YwNKpOKYENTBL0XEg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4357dtSa1640613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 5 Apr 2024 16:39:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnI+vvljflrxQZPICT/uLiBn2l6aADS9fgfqqZRPJP2N0jNcO272WBpclUX7YQKjsGe9u5cBWUqtkzjEJ91Y09K6Hs4N6ptu8dyAmY4/k+hA6DXntLASuVk0Ys89Hiz6PVl2bI3ERruTgbvGL2KEWE7aHOlDv/HHV0vUi0EwHBOnHh+Bmv44GIb+aP+HFSrcbzJqKtR8csWWvQlqXULd0mQ3YbQxNShzA/guv8qpE/RIMBS3QFdro5uDdhoxnandBuwlyiFr5aPEd3hwlHASlbBMZExuie3Txz8MaVEk9b+bULsAzgLt1/EH4sNOJKq2Njs7IMixaRb6DEHAxQb25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4W47nKkVw/osiYO4NVoFpFT/qGV3Ku/ksBmCRUNd+w=;
 b=Qs7nFcjaBbkqSb6FZrj6lV1tIoBoDUrbpIcOQ5ZywXFh5Fq5/ARCKpVRUIljmItHeeg2Q/JxIU1r8Q4rdDkZx8h4jCwp3DIdueWK8TeC1S85+p10x1SVoQWdKS5RmsHwxYI78ZnX0AbMNdeDqcBTS4umJzxm8sVKI0oZeZHo+ucUWmIZiwcA8X2DgKWCKJZ2oKTH9UzEPunMd5Poklj9onguC6vMcWOkPztuu0Qq9iOPKY445hVHcCDQu0bdpZf8iVx+CwnCMl26cmm44gzMxW4hZDGZV1scWogVqoAIwu6c3Bo3V5KanaXMf1GXmwnhWMF3fHXf6hwIz+HBAz+rMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <schilling.benjamin@siemens.com>,
        <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <minmin@plathome.co.jp>
Subject: Generic x86 kernel configration (RE: [isar-cip-core][PATCH] Add
 support Plat'Home OpenBlocks IoT VX2)
Thread-Topic: Generic x86 kernel configration (RE: [isar-cip-core][PATCH] Add
 support Plat'Home OpenBlocks IoT VX2)
Thread-Index: AQHahyxyY4LBwup8/E+w5N5S8lGX9A==
Date: Fri, 5 Apr 2024 07:39:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388EFEF8FAA99557205AB4092032@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <TYVPR01MB11245F45500C758184F6369A092C5A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <5367.1711107559199640802@lists.cip-project.org>
 <2fa52e58-0ba5-4865-adac-3dbe03c9b83e@siemens.com>
In-Reply-To: <2fa52e58-0ba5-4865-adac-3dbe03c9b83e@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB10708:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /TO5uVUqRtx0xVLsCjTAfe3wZReyw/bDJPtTEOBEP/ZXqLAzsP5A4r+C6QFd4Zb0wZRqnOzZh2jNf2Sh3UL8PJlsrs8XTMxiU6up8or34Wk5KwfYzkg/3KgyaQU3GM2EzbQFGqnt1GJqYWP9gyaQAJKGKEXyrpAk6Et6d4axrYQu4GWs0jrW9SM0CbnSisJSueDUC6n4mw7cKwfQ2/JYrs5vQ/LJXXHfCZLKCkuX6FSNOQmp8vAo12pqJUBqv7klq2iKPigx7OLNwEwvxsKu/3wPX0L4pLckEaTB3WVfnAJ3snBsuA6foKOPKb6FE0aGcp/QgDVlQGRYHLm1jb+lgvdksxMfM+GZ68lCXss25LbGTGbo4PrP2OWxqQSuy7IzBfNIZyM2Z2tSQQbdZnVcArZnYQYRAQmHKIKl9jIr2kMilkvGiNdrF8h0gjIPVJlLrcWUn09CnI//C7d2Svz/DkI0X5C5BycdlDDgxw6wUj+zKA+/tyfaSMAiSFqJ1gf4HRyx6+xss/7y8Q+QiB1pu6arnlyr8MWUfqLB3i6YGCXLniAv/3K0mT4zPvQ8AhB31IJw5xKIrV1A5lFGvxfyK3HEFMx1ESwBoA5lr5KC6Ds=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWp4UWRBMjFaZ09oY0ZzTDZ0TFRJZ04xclIzemo4V1dmUVlLZlFXMmdxQzdt?=
 =?utf-8?B?eUZpczgvVFhmSm5WN2tEU1E2NXUvamd5RHBmb1EwVUF2dk51UWtCOVhzM2lw?=
 =?utf-8?B?R3IzS2xLSUt4WTFkN3RWUElibDVHNlk1REhYTGh3OFZaaU9pVE56Vzg5YjdI?=
 =?utf-8?B?THpMdFdXNTFsQi9lSjg1dXk5SC9ybnRpUjVRcFZxNlBjQzFGSFNqQTFTQTR3?=
 =?utf-8?B?NXBVSEFxUm5HTHIrSUdhVjZTUmMrbE4yb2dPenFFOHVkUmFOYVlERi9OTU9p?=
 =?utf-8?B?VVFxdzN6OTFCZ2xnbVRKOXV3VEQ0RzRmYWpmVjlqcjdlc29PcUcxNDJjS29W?=
 =?utf-8?B?K1JrbHNIbVJ5NWpjK3RhV0xOK1RGQnFuTk9mejlZVG80cE4vdU1HLzBLVWps?=
 =?utf-8?B?MVRXZm9wSnovZ1laSndCRTJLQ1RwdlpjN2JmaHFkTUh2dis2UVBlK0QwQnNh?=
 =?utf-8?B?eGE3clFxaG1RTUpsUjh0bUhnTHlVY3JUbDk3S2RGZlQyS2ZLS2RJcGh2dFhm?=
 =?utf-8?B?eTF5L0N6SFFGeUN4SjNOSXRKT2NMUS9pWE9ySU5RZzM3bU5oc1BQQ1lidXlI?=
 =?utf-8?B?WitpNUE1UTVzNnZOZWtuUkxSdGlpTzNVMmV2TkJaRi8yNTV6STZzSEdWeVJK?=
 =?utf-8?B?dDUrd3dtZUJ5OUdDeGs4NFdiY3E1dXhCc3c1N3R4V3JueTJZZThpc3ZuN3JJ?=
 =?utf-8?B?YnlIYWM4QStLRERUVDlqbXhSVC8vRnp5MmVGeS80UnU5Um9rTC85K21lU0hY?=
 =?utf-8?B?d1BtUHZQUk83ZURrNGJvaXhyWlVjYU9tazFpK0NzL2t1MDR3bmN4a3kwbURw?=
 =?utf-8?B?b3RWdW8zZXlLMlI1M2lvUW9DaGg5R1dJYVFOU010YVR2VkVVZEtSemc1eEdy?=
 =?utf-8?B?Y0w2dUNpV0lQeTUyYjVLQTU0a3Btc2pZeGEydHA1OTB3b2NadEFkRjcvZ0hP?=
 =?utf-8?B?a0ZTdXFWcHFXcXBwZDhlaE1vSkdxNld2NW1yaFVtM0lZT2dsUTU3V012aW9o?=
 =?utf-8?B?OFY2ajhaeGt4UzVzVW0wQW5hOVRDQXpVdEhhdWtHQ3l4dHo2WXNDV3J1SGFs?=
 =?utf-8?B?T3BhREFnczZSSnYrTHBnYnY5QU1YSFl2MzNlQ2FkT3NtQlZnVldsck5IV1d2?=
 =?utf-8?B?c0l6Y3lnWVJKZ2ZEQkdGNm1PaUE5dXo0V0ZLQTlvcVY1Y1B0Z2MweVRISnN1?=
 =?utf-8?B?Y2VMZENPK0dpVnlsU1JRUy9Da1hhelhPU3lGR1oxUlZLczZUaTlKQ3RyVUJK?=
 =?utf-8?B?RHpOZ01kbDlReDJNVnBWck85Tk5TdUZLNGJ6QXNVWHdTa2NQakoxNFhKeVZG?=
 =?utf-8?B?TDhWQU1GQTEvR0lmRXNOQnNpTEtlc2dyYngrNDB2MEpPcGdCY3o2VWVhVzZE?=
 =?utf-8?B?eGJVbkhMaFdEem85Z0FVUllNUU8zcWhOQ2FNYm1NVTlaSm9OSzA2RDhjNnpV?=
 =?utf-8?B?TWNkYmdtc0FISUFLQ21JdjVUM1BvR3d2STdHSkxwak1ybDMyajlXOGI4alAv?=
 =?utf-8?B?ZGhoSHVkU2lhTHNRa25RUzF1VDZDU045WXV5eittd2pLYmNlVllUOVFhazRD?=
 =?utf-8?B?MmhNSXVoekZ4eWlVRWpZT2szWm0rL3ZwWllnT29RSDFCRXRPVUFZam8xZExI?=
 =?utf-8?B?R3M3aHNwUXZLSUJiWHFoUEI5emRXUVZFYjlYY2tWKys5MndYSHRxbUdwVmly?=
 =?utf-8?B?S1FZRldwd2hrWjJ0VWFuQlpMOHJNelRHenJDZWpzMkszQU9TdW1jTUcyM1NX?=
 =?utf-8?B?ZkNpZ1V4a1NWbFRCZThoSGl1TXREL2VBUlBIZTBpaFlnTGhMRzkzNWJWblhP?=
 =?utf-8?B?dUg0ZnJvV3luQnAzQVZ3dTJMZXB6djFMV2hNRHlyd2dCUzNLL0tYeTFDWHZs?=
 =?utf-8?B?NGF2TStOdEZ4bklFM3dVa3hIeXM3Rmx1U0JKZzlVQzF2SjNrSEhseVloWDN5?=
 =?utf-8?B?c1NyMkQzKzhaUFJpdDdWNyt5Nmt0V2xZOGp1a3k1c0xGT05ybWYxanlwN21Y?=
 =?utf-8?B?cUxwUWpIaEVodDFTK1R6NUE2VW4ya3UvclAxV05rZGNmdk9wNmFRZmppaXh2?=
 =?utf-8?B?dDZiTGJXcVBRTWhBWityb3o5Zy9hT3Rjb0Uxa3FoSDdRc2txSnZrVlhqbWZR?=
 =?utf-8?B?MVVtVFo5bjZlZVdkUmxjVGM4TEpEeXFmSkdwYUpiRzJGaThRb0pnOS9xeXZy?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356352de-b3a9-40f3-0f3c-08dc554394fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 07:39:53.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwgyJTriZJykQm+xcMm4LOF008m6sfsvZCazV/+C3aNIpfX17s6KVRSaFKTQwehei0yw5auTJ0YOHhTepPi6v9n7qhx4+bihJ5xmZwxO7QahYVhkpjoaiYfqYPJjIXip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10708
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Apr 2024 07:40:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15493

SGkgYWxsLA0KDQpGaXJzdCBvZiBhbGwgSSBjcmVhdGVkIGdlbmVyaWMga2VybmVsIGNvbmZpZ3Vy
YXRpb24gZm9yIHg4NiBDSVAgcmVmZXJlbmNlIGhhcmR3YXJlIGFuZCBwZXJmb3JtZWQgYm9vdCB0
ZXN0cy4NClRoZSBjb25maWd1cmF0aW9ucyBvZiBlYWNoIGRldmljZSBpbiBjaXAta2VybmVsLWNv
bmZpZyBhcmUgbWVyZ2VkIHVzaW5nIEtFUk5FTC9zY3JpcHRzL2tjb25maWcvbWVyZ2VfY29uZmln
LnNoLg0KQWxzbywgYm9vdGluZyBpcyBmaW5lWzJdWzNdLiBCdXQgdGhlcmUgYXJlIGEgbG90IG9m
IGRpZmZlcmVuY2VzIGluIHRoZSBjb25maWd1cmF0aW9uc1swXVsxXSwgc28gSSB0aGluayB3ZSBu
ZWVkIHRvIGRlY2lkZQ0Kd2hhdCB0byBkbyB3aXRoIHRoZW0uDQoNCkFib3V0IE0tQ09NIHg4Niwg
YnV0IEkgaGF2ZW4ndCBpbnZlc3RpZ2F0ZWQgaXQgeWV0Lg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5v
YnVoaXJvDQoNCk1lcmdlZCBjb25maWc6DQogICAgaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1
L2NpcC1tZXJnZS1jb25maWctd29yay8tL3Jhdy9tYXN0ZXIvY29uZmlnDQpEaWZmIHdpdGggaXBj
MjI3ZSBvcmlnaW5hbCBjb25maWcgWzBdOg0KICAgIGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRz
dS9jaXAtbWVyZ2UtY29uZmlnLXdvcmsvLS9yYXcvbWFzdGVyL3NpZW1lbnNfaXBjMjI3ZV9jb25m
aWcudjYuMS44My1jaXAxOC5kaWZmDQpEaWZmIHdpdGggT3BlbkJsb2NrcyBJb1QgVlgyIG9yaWdp
bmFsIGNvbmZpZ1sxXToNCiAgICBodHRwczovL2dpdGxhYi5jb20vaXdhbWF0c3UvY2lwLW1lcmdl
LWNvbmZpZy13b3JrLy0vYmxvYi9tYXN0ZXIvcGxhdGhvbWVfb2JzdngyX2NvbmZpZy52Ni4xLjgz
LWNpcDE4LmRpZmYNCktlcm5lbCBzaXplOg0KICAgIDc3NjA1NDQgYnl0ZXMNCg0KaXBjMjI3ZSBi
b290IGxvZyAobWVyZ2VkKVsyXQ0KICAgIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hl
ZHVsZXIvam9iLzExMTMyNTkNCiAgICBodHRwczovL2dpdGxhYi5jb20vaXdhbWF0c3UvY2lwLW1l
cmdlLWNvbmZpZy13b3JrLy0vcmF3L21hc3Rlci9pcGMyMjdlLW1lcmdlZC5sb2cNCmlwYzIyN2Ug
Ym9vdCBsb2cgKE5PIG1lcmdlZCkNCiAgICBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2No
ZWR1bGVyL2pvYi8xMTEzMzU2DQogICAgaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2NpcC1t
ZXJnZS1jb25maWctd29yay8tL3Jhdy9tYXN0ZXIvaXBjMjI3ZS1OTy1tZXJnZWQubG9nDQogICAg
a2VybmVsIHNpemU6IDcyNTEwNzIgYnl0ZXMNCmlwYzIyN2UgYm9vdCBsb2cgKGRpZmYpDQogICAg
aHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2NpcC1tZXJnZS1jb25maWctd29yay8tL2Jsb2Iv
bWFzdGVyL2lwYzIyN2UubG9nLmRpZmYNCg0KT3BlbkJsb2NrcyBJb1QgVlgyIGJvb3QgbG9nICht
ZXJnZWQpWzNdDQogICAgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2Iv
MTExMzMwMQ0KICAgIGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9jaXAtbWVyZ2UtY29uZmln
LXdvcmsvLS9yYXcvbWFzdGVyL29icy1tZXJnZWQubG9nDQpPcGVuQmxvY2tzIElvVCBWWDIgYm9v
dCBsb2cgKE5PIG1lcmdlZCkNCiAgICBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1
bGVyL2pvYi8xMTEzMzAzDQogICAgaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2NpcC1tZXJn
ZS1jb25maWctd29yay8tL3Jhdy9tYXN0ZXIvb2JzLW5vLW1lcmdlLmxvZw0KICAgIGtlcm5lbCBz
aXplOiA5MjAzMjk2IGJ5dGVzDQpPcGVuQmxvY2tzIElvVCBWWDIgYm9vdCBsb2cgKGRpZmYpDQog
ICAgaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2NpcC1tZXJnZS1jb25maWctd29yay8tL3Jh
dy9tYXN0ZXIvb2JzLmxvZy5kaWZmDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCAyNiwgMjAyNCAzOjUyIFBNDQo+IFRvOiBCZW5qYW1pbiBTY2hpbGxpbmcgPHNj
aGlsbGluZy5iZW5qYW1pbkBzaWVtZW5zLmNvbT47DQo+IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KW
oe+8pA0KPiDvvKnvvLTil4vvvK/vvLPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcD4NCj4gU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gQWRkIHN1cHBvcnQg
UGxhdCdIb21lIE9wZW5CbG9ja3MgSW9UDQo+IFZYMg0KPiANCj4gT24gMjIuMDMuMjQgMTI6Mzks
IEJlbmphbWluIFNjaGlsbGluZyB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBJJ20gam9p
bmluZyB0aGUgZGlzY3Vzc2lvbiB0byBzdGFydCBpbnRlZ3JhdGluZyB0aGUgTS1DT00geDg2IHN1
cHBvcnQuDQo+ID4gV2hhdCdzIHRoZSBzdGF0dXMgb24gdGhlIGdlbmVyaWMgeDg2LTY0IHRhcmdl
dD8NCj4gPg0KPiANCj4gTm9idWhpcm8gd3JvdGUgcmVjZW50bHkgaGUgaGFzIGEgcHJvdG90eXBl
LiBNYXliZSBoZSBjYW4gc2hhcmUgdG8gZmluYWxpemUgaXQNCj4gdG9nZXRoZXIuDQo+IA0KPiBK
YW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENl
bnRlcg0K


