Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCDBC48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:29:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.44168.1707924553840973070
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 41EFTCci2046330; Thu, 15 Feb 2024 00:29:12 +0900
X-Iguazu-Qid: 2yAaYKYb3A2s2kITWy
X-Iguazu-QSIG: v=2; s=0; t=1707924551; q=2yAaYKYb3A2s2kITWy; m=uP/SrDnyOgkZxesZMePqZBAGxyuiKdFRR8AnTcpiyAI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 41EFTADZ3151934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:29:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyesOS7Ad9lIc4SVeVipo4MXGB/g07M1JCxVU5NLjrtw3z28pqiO687+xzZ9ntufQvYXcS4hjw+oylQzDKlZyEu/m5+2hkakoK6tskzjMb3+T4EdZ6+IAFwy8gq6UoRJIpNxr4BUuxYTJ3e68Bq1hmWbBQLkAaHtsfuLLNsjHeiVPcInCIOikXvOTC/USAfEEvMR7ZJyNhefawb5eSSWIodO0pS6xsF0TKiBP2awL64MpFsp822fU3BupnFNmS7Mjc1g5KZs0KQzk+LTB+apFLG6ovslYEMul8NuVuxWoup8Gkx7k3m34EgKhCz9+M5+yz2DWzxIPeSCzpL8Vmvkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3NHUqLRhav/dZnz1y1hTr73uuww6BBtNcVOLix6wg0=;
 b=L2VEQWtbLtfoMhIcq/eW3Vwhc+CZHDa/n54o20yF+G0uJexJ7TnhqRTe0Akx7sb3PxChYlfIX3/S+nNvoNsz0nVvrO9xEwqWWWQvyIgrV7QG2ayTLcpmir4pwBfqFVXx0ryYcBjVxnj+RIykKymK4qNud3Lyvu1MOijpB0B8ZQpfKNyRj4dXOt61t20wkOMEVFm6Gh6Rk2ypcXsdUP/8WsYTUnYB40u4FevxWwLpuFcIiJR3BjFDvhYyiugxzlBcCID7Lhcl2o6Cqw1F3xHhwEP4ZM+YBLDVNDgPQlBeVFm9Xcwb5d10apm5kVcd9+wUceXupJtp/C63RxR04ARMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core 2/2] .gitlab-ci.yml: Add v2 QEMU
 security targets for swupdate testing
Thread-Topic: [cip-dev] [isar-cip-core 2/2] .gitlab-ci.yml: Add v2 QEMU
 security targets for swupdate testing
Thread-Index: AQHaX0FHpQdnKHvZTUCkGsaugf8XtLEJxjgAgAAwA2A=
Date: Wed, 14 Feb 2024 15:29:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103D22C59341ADD40442C6DC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214122809.3541505-3-Sai.Sathujoda@toshiba-tsip.com>
 <aeeaf536-bfd4-43ff-a4ff-f4f19819a27d@siemens.com>
In-Reply-To: <aeeaf536-bfd4-43ff-a4ff-f4f19819a27d@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY3PR01MB10986:EE_
x-ms-office365-filtering-correlation-id: f0f0cd84-54e0-40cb-bef9-08dc2d71b00f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 coXHO9AfYGVA8aryZONmrKKlnadhHqtIVxX7DXDu1bUaWK+cyJQfv99+veUeDtE0vEfa9nk/53ZBIQwBjEIXIa0lNhtonrZDa1NSTkg1yg2VWEP6OsqFNOcbCBdsXgVNPmCkLglIrmA28KFQSMbK1MnhZ2xH88Uqsy/f9PwXF8EfLC/VuIiNscnBXV4rRYnYP0dkwIrrohgQr/SNtk4qqaEWPpZF3xJhfgr5stZ74t7N+BaaSthiM9XjHx1tVxYVaesOFT2cCgCA00AHJIkkOcwxxAgbcdlxDQRngJD/ObqSH3RZ19bb3VwfNlDr9r9jLg5j8oYgE17SVE74LtBy495qFEozz9FEpCaHsYeEjC6DDlL2mE4yhWKsP7E908TznwJl8m2jtBz+kTfMIHZksUR6g40+DmwZfOH6zVSHTJ8uONAq4t0YpOVoh6aUK45Qp2GtkF0D/oiymjsQsdsVDrvlqh06LTB3WjrLd8EMy040JP3Bg9h0VYwx0w9PcLkdrljvXzsFrIOtevciUo52UKBAknAhjMQRudkfzYtlOH2aHoyL0+m86pG10u1Sfm2y4lqJHeYhF/wD7nIhWZpwHghkY77L3JzmcXZ1g8RHi6hrs85F8M9MFgvZEDcErOMF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(8676002)(66476007)(5660300002)(8936002)(64756008)(66446008)(76116006)(66946007)(66556008)(52536014)(2906002)(15650500001)(83380400001)(38070700009)(26005)(33656002)(122000001)(85182001)(86362001)(71200400001)(38100700002)(6506007)(316002)(54906003)(110136005)(41300700001)(53546011)(9686003)(478600001)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ekJrbFJrTk5hcEl6Wk54bkR3SWFsdmY0TGtwZ2xrVjdYWC9WbWwyQU9RMkwr?=
 =?utf-8?B?YnkwUHVHRWNtUmF3dTYxbmpQdEwyN0YvUHBPby9nTVRPMzVnOTQ3dmU2UFJp?=
 =?utf-8?B?czVzWVZ0UzNoVG5XbW5EdjJ5UmdPQWtweGRHQm1qbjZQei9teXBJNk1iL3Bp?=
 =?utf-8?B?SmVMT3hUb2hndVlXNHZBTkZkVndiRENtbEtKWkZVeFBUR3BEQm5LQXpnVC9S?=
 =?utf-8?B?dTF1WU9jd1dXZUc2TEhMSU5XdWpBd05QMDQyZWFheGdvSFJxZWxKZGFrL0pp?=
 =?utf-8?B?SzdHRzFZMVRyNHYxbEx6ZWgxRjZjZm00Q2htQXVIZzh5SjZhbzdwTTh5c3Rs?=
 =?utf-8?B?SXVRTHNMaS9XTXdZOE1hcFZvdWtKYjI5U0RVMjEwTWFqQ1Q0TWw4alhUaXhB?=
 =?utf-8?B?VVo1alZyY0RXNVh1R09SeDU3Mit5dU9xMDhVRkI3UkowenNHZk1HWjc1TkIv?=
 =?utf-8?B?SitldkJKVDUra0lHV1VzTElhdkRoeXhQMy9vS3NuM1IxenVDOWhLNHpnVktu?=
 =?utf-8?B?WE9pSXNUdWZFeG45bGp6Tzh2ZEswbTJ4emRINlg2dnB0bFViNkh0NkFzdlAw?=
 =?utf-8?B?Y0ZjUzZzS3dkZjN0azlOS1ZMcTdJM09MUU9rS01YR2x4ano2SGhzRzNmVERr?=
 =?utf-8?B?U3BmNGxFbHJBZTV0T013Qy9lanNtQTJEMHE3dVRoL0lMUmtoT2c0QW1NQnZs?=
 =?utf-8?B?enQ4SzJ1ODFnZTREWWdPODgyczdnWFZsOTJPT2dGaUl1SVdTeTFiZ1ZDcElq?=
 =?utf-8?B?RGFrckV5OERGeGlvNyt1K3d2eVUrS2pySWFiVzJHL0FXeGFwMDBXTjZRYkhw?=
 =?utf-8?B?WHBraWJ1NDYvU1Z3KzNXdVBHQzlWUG54bjMwbklqb29vdHdVWC9YckFJVFBI?=
 =?utf-8?B?alVyZkltVW9kTE9teGdOWkdEMi82Tkc2WnR3WXZMV1RUSjRqdjd1b2JTY21G?=
 =?utf-8?B?VTRsRVgzc3BPUkRFczdPZ1RiZWVyRWdzdndjWnNXdFVLREFWLytqNVRIZzkz?=
 =?utf-8?B?cVYrM2dOZXJUb3RaNnhqc3lUcXN2Y0xaVXlNaUlsSmJyOXIvMnI1NkpZdjVs?=
 =?utf-8?B?MHovaUVPdTRPUlYzNXlGNGpkYWN1cDVZZTlXK1lnUDYvVjk3b2w5bkNhT0xO?=
 =?utf-8?B?ZkY0MlowdGwxWVRUVTlnbmZZMG9zOUhWL1VNbHFGaFRrSlo5S2hlMTgzajB5?=
 =?utf-8?B?RjZDN0M5YTFGRklncVVkVXF0RkYxVmdrSGdXcnRHT21COFcyd2tIVXF4UUpQ?=
 =?utf-8?B?QzFUNEVZVnhDVytBdHlDUy92SDl3ai9jUUNHOXBrUW1LTHZEVTFsS00wcVcy?=
 =?utf-8?B?RjcxREtrYzRjQklzYzI3VmkxTDVRK0RHMnJIdGNLRElTUW1jeG9ESDNHeXAy?=
 =?utf-8?B?RExDQUUyQ3dNeTNDLy9jbzBQZnY5bWY5bmRpTGllaWl5OHZUY1FiU05sczhr?=
 =?utf-8?B?OVJaZnVsaGxqeGc5Y0pWVERPQXZHWVQxNlFyMnRXeFoyMGk2R1dkelZUSjZp?=
 =?utf-8?B?NHZzR05wUVhRdWtiTXhsSFR6NmxTY3JBTGp2b1ZGQ0M4UVR5R2pxdElwM0o3?=
 =?utf-8?B?ZWxZaGhOSlhadVk3SjdKSnQyZ29XKzVkUFJHdWI2U09lRkJ1SEFJVkJKdmhj?=
 =?utf-8?B?MFdieWhRWG1LVVdtRHVJWFZibnVUNHBTbXhLWkFSZHpNaXFiMDR5YlFabTR6?=
 =?utf-8?B?OXE1QlducUk5Ly9wV2tOcmI5elh3QjZIT3NKMkVNdStzZ3hLS0ZOVS9EdGl4?=
 =?utf-8?B?Z3pWc0JNZkRzV2hmYXJRVkxONC9iVGZDT3dGbUZYd3lqdjJ1QjIzYnN5QWFv?=
 =?utf-8?B?Nk8rN0R6UGRaSnFubUdxOVRPWVlSSUhCRTcrUGdualJhK1ZLOFU3Ukw1V0k0?=
 =?utf-8?B?bWd0ZHdrTVd2OXM1aStEVGM2Z2ZaNm42d1d6ZTNmVm5tMEZCM3c0VnJOSFZP?=
 =?utf-8?B?WmRiUXJ5VVh1OGsxTXBsVlBnN2l6eVVZYTBpMHdkcjNOb2ZBS1hDV3RaRldV?=
 =?utf-8?B?bitXUXArTU9VSUZ1RlBpYnpsOHlTeEwwUklja2I5OHk2a1FpUDBWbno2OGIx?=
 =?utf-8?B?bThrd2VZWDZSSGpCc3JCRU8yUTRLaVZwU0hiUUt1NDBoNTA1ejNUbHFmUS84?=
 =?utf-8?B?ZjRjV29DUzY3T0E3ZE5keDVNbGhpRENyZnFhaTVTVFpoRm8vT0NjSnZJblRh?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f0cd84-54e0-40cb-bef9-08dc2d71b00f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 15:29:08.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GNNIKPz4IwtLtmvlbkd4+/ZifruMPLs5fZCmDOBktcvOfWMcT665edAfR/wI3FXaYKIOPa4oYlJIh1FpuWC8yFNdKoCGJF1lAoLD811nn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:29:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14974

SGkgSmFuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIEkgYW0gc2VuZGluZyB2MiBwYXRj
aGVzIGJ5IGNvcnJlY3RpbmcgdGhpcyBmbGF3LiBQbGVhc2UgcmV2aWV3IHRoZW0uDQoNClRoYW5r
cyBhbmQgUmVnYXJkcywNClNhaSBBc2hyaXRoIFNhdGh1am9kYQ0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE0LCAyMDI0IDY6MDYg
UE0NClRvOiBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEt
dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1h
cijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10
c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp
77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5j
by5qcD47IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQpT
dWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlIDIvMl0gLmdpdGxhYi1jaS55bWw6
IEFkZCB2MiBRRU1VIHNlY3VyaXR5IHRhcmdldHMgZm9yIHN3dXBkYXRlIHRlc3RpbmcNCg0KT24g
MTQuMDIuMjQgMTM6MjgsIFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4g
RnJvbTogU2FpIFNhdGh1am9kYSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAN
Cj4gRm9yIExBVkEgc3d1cGRhdGUgdGVzdGluZywgdjIgUUVNVSBzZWN1cml0eSB0YXJnZXRzIGFy
ZSBidWlsdCB3aXRoIGEgDQo+IG1pbm9yIGNoYW5nZSBpbiBjaXAtY29yZS1pbWFnZS1zZWN1cml0
eS5iYi4gYW5kIHRoZWlyIC5zd3UgYXJ0aWZhY3RzIA0KPiBhcmUgZGVwbG95ZWQgdG8gczMgYnVj
a2V0cyBmb3IgdXNpbmcgaW4gTEFWQSBqb2IgZGVmaW5pdGlvbnMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTYWkgU2F0aHVqb2RhIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+IC0t
LQ0KPiAgLmdpdGxhYi1jaS55bWwgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdpdGxhYi1jaS55bWwg
aW5kZXggNGY4N2VjMy4uYzc4MzdmNCANCj4gMTAwNjQ0DQo+IC0tLSBhLy5naXRsYWItY2kueW1s
DQo+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+IEBAIC0yNSw2ICsyNSw3IEBAIHZhcmlhYmxlczoN
Cj4gICAgZHRiOiBub25lDQo+ICAgIGRlcGxveTogZW5hYmxlDQo+ICAgIGRlcGxveV9rZXJuZWxj
aTogZGlzYWJsZQ0KPiArICB1c2Vfc3d1OiBkaXNhYmxlDQo+ICANCj4gIHN0YWdlczoNCj4gICAg
LSBidWlsZA0KPiBAQCAtNjMsOSArNjQsMTAgQEAgZGVmYXVsdDoNCj4gICAgICAtIGlmIFsgIiR7
cmVsZWFzZX0iID0gImJvb2t3b3JtIiBdOyB0aGVuIGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omth
cy9vcHQvYm9va3dvcm0ueW1sIjsgZmkNCj4gICAgICAtIGlmIFsgIiR7cmVsZWFzZX0iID0gInNp
ZCIgXTsgdGhlbiBiYXNlX3lhbWw9IiR7YmFzZV95YW1sfTprYXMvb3B0L3NpZC55bWwiOyBmaQ0K
PiAgICAgIC0gaWYgWyAiJHtlbmNyeXB0fSIgPSAiZW5hYmxlIiBdOyB0aGVuIA0KPiBiYXNlX3lh
bWw9IiR7YmFzZV95YW1sfTprYXMvb3B0L2VuY3J5cHQtcGFydGl0aW9ucy55bWwiOyBmaQ0KPiAr
ICAgIC0gaWYgWyAiJHt1c2Vfc3d1fSIgPSAiZW5hYmxlIiBdOyB0aGVuIGVjaG8gIlBWID0gXCIy
LjBcIiIgPj4gDQo+ICsgcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0
eS5iYjsgZmkNCj4gICAgICAtIGVjaG8gIkJ1aWxkaW5nICR7YmFzZV95YW1sfSINCj4gICAgICAt
IGthcyBidWlsZCAke2Jhc2VfeWFtbH0NCj4gLSAgICAtIGlmIFsgIiR7ZGVwbG95fSIgPSAiZW5h
YmxlIiBdOyB0aGVuIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoICR7cmVsZWFzZX0gJHt0YXJn
ZXR9ICR7ZXh0ZW5zaW9ufSAke2R0Yn0gJHtDSV9DT01NSVRfUkVGX1NMVUd9OyBmaQ0KPiArICAg
IC0gaWYgWyAiJHtkZXBsb3l9IiA9ICJlbmFibGUiIF07IHRoZW4gc2NyaXB0cy9kZXBsb3ktY2lw
LWNvcmUuc2ggDQo+ICsgJHtyZWxlYXNlfSAke3RhcmdldH0gJHtleHRlbnNpb259ICR7ZHRifSAk
e0NJX0NPTU1JVF9SRUZfU0xVR30gDQo+ICsgJHt1c2Vfc3d1fTsgZmkNCj4gICAgICAtIGlmIFsg
IiR7ZGVwbG95X2tlcm5lbGNpfSIgPSAiZW5hYmxlIiBdOyB0aGVuIA0KPiBzY3JpcHRzL2RlcGxv
eS1rZXJuZWxjaS5weSAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0gJHtkdGJ9OyAN
Cj4gZmkNCj4gIA0KPiAgIyBiYXNlIGltYWdlDQo+IEBAIC0xMDYsNiArMTA4LDE4IEBAIGJ1aWxk
OnFlbXUtYW1kNjQtYmFzZToNCj4gICAgICB3aWNfdGFyZ3o6IGRpc2FibGUNCj4gICAgICB0YXJn
ejogZW5hYmxlDQo+ICANCj4gK2J1aWxkOnFlbXUtYW1kNjQtYmFzZS12MjoNCj4gKyAgZXh0ZW5k
czoNCj4gKyAgICAtIC5idWlsZF9iYXNlDQo+ICsgIG5lZWRzOiBbYnVpbGQ6cWVtdS1hbWQ2NC1i
YXNlXQ0KPiArICB2YXJpYWJsZXM6DQo+ICsgICAgdGFyZ2V0OiBxZW11LWFtZDY0DQo+ICsgICAg
ZXh0ZW5zaW9uOiBzZWN1cml0eQ0KPiArICAgIHVzZV9ydDogZGlzYWJsZQ0KPiArICAgIHdpY190
YXJnejogZGlzYWJsZQ0KPiArICAgIHRhcmd6OiBlbmFibGUNCj4gKyAgICB1c2Vfc3d1OiBlbmFi
bGUNCj4gKw0KPiAgYnVpbGQ6cWVtdS1hbWQ2NC1iYXNlLWtlcm5lbGNpOg0KPiAgICBleHRlbmRz
Og0KPiAgICAgIC0gLmJ1aWxkX2Jhc2UNCj4gQEAgLTEyOCw2ICsxNDIsMTggQEAgYnVpbGQ6cWVt
dS1hcm02NC1iYXNlOg0KPiAgICAgIHdpY190YXJnejogZGlzYWJsZQ0KPiAgICAgIHRhcmd6OiBl
bmFibGUNCj4gIA0KPiArYnVpbGQ6cWVtdS1hcm02NC1iYXNlLXYyOg0KPiArICBleHRlbmRzOg0K
PiArICAgIC0gLmJ1aWxkX2Jhc2UNCj4gKyAgbmVlZHM6IFtidWlsZDpxZW11LWFybTY0LWJhc2Vd
DQo+ICsgIHZhcmlhYmxlczoNCj4gKyAgICB0YXJnZXQ6IHFlbXUtYXJtNjQNCj4gKyAgICBleHRl
bnNpb246IHNlY3VyaXR5DQo+ICsgICAgdXNlX3J0OiBkaXNhYmxlDQo+ICsgICAgd2ljX3Rhcmd6
OiBkaXNhYmxlDQo+ICsgICAgdGFyZ3o6IGVuYWJsZQ0KPiArICAgIHVzZV9zd3U6IGVuYWJsZQ0K
PiArDQo+ICBidWlsZDpxZW11LWFybTY0LWJhc2Uta2VybmVsY2k6DQo+ICAgIGV4dGVuZHM6DQo+
ICAgICAgLSAuYnVpbGRfYmFzZQ0KPiBAQCAtMTUwLDYgKzE3NiwxOCBAQCBidWlsZDpxZW11LWFy
bS1iYXNlOg0KPiAgICAgIHdpY190YXJnejogZGlzYWJsZQ0KPiAgICAgIHRhcmd6OiBlbmFibGUN
Cj4gIA0KPiArYnVpbGQ6cWVtdS1hcm0tYmFzZS12MjoNCj4gKyAgZXh0ZW5kczoNCj4gKyAgICAt
IC5idWlsZF9iYXNlDQo+ICsgIG5lZWRzOiBbYnVpbGQ6cWVtdS1hcm0tYmFzZV0NCj4gKyAgdmFy
aWFibGVzOg0KPiArICAgIHRhcmdldDogcWVtdS1hcm0NCj4gKyAgICBleHRlbnNpb246IHNlY3Vy
aXR5DQo+ICsgICAgdXNlX3J0OiBkaXNhYmxlDQo+ICsgICAgd2ljX3Rhcmd6OiBkaXNhYmxlDQo+
ICsgICAgdGFyZ3o6IGVuYWJsZQ0KPiArICAgIHVzZV9zd3U6IGVuYWJsZQ0KPiArDQo+ICBidWls
ZDpxZW11LWFybS1iYXNlLWtlcm5lbGNpOg0KPiAgICBleHRlbmRzOg0KPiAgICAgIC0gLmJ1aWxk
X2Jhc2UNCg0KVGhpcyB3aWxsIGJ1aWxkIHYyIGluIGEgc2VwYXJhdGUgam9iLCBubz8gTWVhbnMs
IHlvdSB3aWxsIG5vdCBiZSBhYmxlIHRvIHJldXNlIHRoZSA5OSUgb2YgdGhlIGJ1aWxkIGFydGlm
YWN0cyBmcm9tIHRoZSB2MSBidWlsZC4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KSmFu
DQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg==


