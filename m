Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D3C4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 14:59:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.23664.1714402766382836827
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 07:59:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43TExNCd4158068; Mon, 29 Apr 2024 23:59:23 +0900
X-Iguazu-Qid: 2rWhGbqYiBMJ08jFGC
X-Iguazu-QSIG: v=2; s=0; t=1714402763; q=2rWhGbqYiBMJ08jFGC; m=on5oU/Pk/iW11w8TFBH0Da53oSq/WrmK1puXFCl3G6E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 43TExLqE276446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Apr 2024 23:59:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA4tl37DVEIU6hTVfY5DvgPfpDFpJrpzenttj+iW3HGyi0Q3pq6fzx9NV1h6P5i/8122pyWeEvpk+tBrX9a3Z44Sf1337/pure8kt5nbXUxide+2QRu1u1UblcZw7wK5zQ0jvuNi3tp03WFXYsNygtbGfqmB91sca980DbfN+usCwwIXu9Url1g70x4Q/hVCciB2DNIUdldeD8q0ZJFpNxo/HDw2mKqarSVK86CCgHCoB/FOPkyMvHWJz6Kk7xl9JQM0A8p5B0OGmkgPuWblKvxqFlWei3V/L2HB9pzRf1t+/qkOJjyCW40LAAho9EU2zqAjg26nIY66otIr9Toz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNNARojRat4wAi16ig9NeOvfvT9Ms0rZvQ31h1YNmKo=;
 b=WLFqhpJdwwt3c2h/txHWbZ476bpGZXtgOgjVyP1INxWl9mgigrFES4RjhvSAzLbc3TOeUjJQM2JIhBrftWbt3NpQ5hzYHQt8WZx4eu9OuBK1U5TgpT9WWy4HH9xEZ58VFI5U6+RIVy8gPcBOHhkcmXsQCv5lCFH8NqgMhYqw8NHYXK+ViX5a06cHV7vbZK7XdCBa9MaOE2/0s+oKf5VaSRZNT2r5VUJj86VtGdZ2WHGzr0K/x+JF0jiuC16wdTU6+yL20hcXD/jibvZZVTLziBwV7yLLhaoFZNB4SsqrHovYxTHeLztOJVC4Ix3V+c+ZkBVGSXDHx91ZXtqR0scKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <quirin.gylstorff@siemens.com>, <felix.moessbauer@siemens.com>,
        <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md:
 Update steps to test Delta software Update
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md:
 Update steps to test Delta software Update
Thread-Index: AQHamjMkC9VCOtmVuEKxgvzT9zJaxbF/NszQgAAU5YCAAArGYA==
Date: Mon, 29 Apr 2024 14:59:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669DE5229EDB9DCCAB077FAC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240425094444.404036-4-Adithya.Balakumar@toshiba-tsip.com>
 <e9c236a6-0d71-4e45-9a95-c5edf8147dff@siemens.com>
 <TYCPR01MB9669AB2FDC68445709AFD32DC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <85a824bc-fbe8-488e-9ea4-5cb100ed5fe5@siemens.com>
In-Reply-To: <85a824bc-fbe8-488e-9ea4-5cb100ed5fe5@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY1PR01MB10801:EE_
x-ms-office365-filtering-correlation-id: fbf3b062-a546-4c20-0e58-08dc685cf281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bGZqUS9IcG5rTGZ1VGNXQXN0aENOaXM2MEx5eVM1Rm5vSURsSVZORXhTTEJB?=
 =?utf-8?B?YWMvSkRRWEZlK3MxeTM5T21adWYyUTQ3RS9QOEFUTlJLcGdEMkREenIxeE5E?=
 =?utf-8?B?S0JBVjZ0L2dRdnV3Qml2SmxnMVFBc2trbHRtSGZYenRsR1FieWUvTzFCWFBq?=
 =?utf-8?B?MzQzNkRwemJIMlNuZlhnQnROLzNQVkRtRk9URTM4ZHBHU1lqZlQ2ZDlYaHhQ?=
 =?utf-8?B?QVlBUVdIdmVXVkR1NVp3NExyM2Rzdjc3cWhNZEVWLzEwMUx5UUlGaDlrYXJS?=
 =?utf-8?B?QU1PeDAwdFhpNjFMU3paWk42RkExbXRFT0VGbWszb1R5SHZnNVBzU0s3akhU?=
 =?utf-8?B?eC84ckl0OTYzRzE4U2xsU1FJV3dnNjFUdUJrRC9Xcm54UWJxcHdBZmR3M1I1?=
 =?utf-8?B?aWhqWWg0aGdTWTA3VnhydWtnR0tPWEhBUG1vWnBHMmcvSjVMaU9UQzhPSUta?=
 =?utf-8?B?VHkySjBGajJjeG05bGFrcCtyWG5OM1NZTURTYmJDeTh6cTk3cmZ5cnZLeXhC?=
 =?utf-8?B?V3BRcGNyM3N1YThvczMzaU9LV1Y2ZWtMZHU1UVZEQ1F2WWFEY3JFSUE1KzBq?=
 =?utf-8?B?aGtIRTc4eXpYRjhnOVV6NFlLZ3IxRVdCV1dKRG5hOUQxOFJOdnVHMVJoVmF1?=
 =?utf-8?B?NGJDOUZjVTg1QjlnengwR1JWYVhYdDNGY2dTWHVCbmpxQXFIVlJib2U1UDdz?=
 =?utf-8?B?bnlUQ0JLZUdHcFFYRDZtWHE4andwaGVzUnVhZGZLMFRKNDRUeHNjU1VKOHBE?=
 =?utf-8?B?MU5TMnZsWCt3ais2ODd0T3hSMXhHYW9QQWszbG1ucXVtQ2NoVjN5ZWMvOVZv?=
 =?utf-8?B?L3c0cjk5RC9hb2tSaHlwSWhLZVFZZW1XVnhFeWIxNW4zTW81V1BuSmhNWmxy?=
 =?utf-8?B?aWVFRFBWTjRqTkF4V2tpcTQ0ZE9Ddi9kT3JNckRjSkd3dVRiV0ZsRzVQUFB5?=
 =?utf-8?B?TW5tY1J6amNQamRSRGNzWlU5eWZnWVJadWE2RjByZjhsdmovWUtiTHJvV1pl?=
 =?utf-8?B?cVlydlE5NlFlUDg0TWxQdi9KVFUzWGxLRWZxQ0xSemt6MG1sQlQrNFQ4Vm9O?=
 =?utf-8?B?NjVTRFI2YURtKyt4YVBWUFczWW9DRVhqdW51OVBQZnBtRTdRYWlBWk45dEM1?=
 =?utf-8?B?dnYyd3A2dnpYRXFzQk1VNHlIUlRrcGNKZFNnbGJEanY2Ymd3Y3ZEQXFnQWpD?=
 =?utf-8?B?S3dSOEJPK25KY3hydGZkRFI5WUc0ekNXQUE2OXB1MDgxRnp6Nk5rc1JEbUMw?=
 =?utf-8?B?N1F4czNLNEVPMUpBVFRKUnhyQlZNMDhWMnVPK2pyN3ord2QwRXErRE1STWJq?=
 =?utf-8?B?QjZabHlHK2ZvM1FvcVBGd1A3REoyMTVVd1BaWXlXdEl1bytDVkhLUWhFRXBR?=
 =?utf-8?B?c01LQXM1cjdxL2lYVUVkNWxTdU90ODNYeGc4UXhNUkVKbUYxd2h2Nmw1RWwy?=
 =?utf-8?B?YjEydlhGU29CS3JpaWdkWDgvWmJONnhiaDFlNUdLOEFyejJLb1JjMGIyY1J1?=
 =?utf-8?B?RG5tTEcxcGdwMXBBdXV3TitiMXVudnkwdzh3SEUvc3ExRU1yZGZlSitPREVQ?=
 =?utf-8?B?UHV4ZllLdWFybFphMW1GNkduZjZ3N0VzMVhBbFJMT25YYkN5eUJLMWJTTTk0?=
 =?utf-8?B?aWtpMi9FcUNTWFJEZ21XcmxGb2dSeDZlYWYwNHg1OXpzdWNFVlNWRWFNUDd1?=
 =?utf-8?B?am9xMlVZMCtMNlBkZVF1ZldmakhiWkJOVjlodmx4c3I2TzF0R21qZHlRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVU1TWxSNGNHUHZJQlRwVWJYTGE3TmhmemxGb2F0d0lGMThKYStnY3BBaVVN?=
 =?utf-8?B?aXEwOWV2cnJEQ1FhQ2cra0dxVnNhb09RaFdwZWJaTGNIdkhHUENaYlVsbWRy?=
 =?utf-8?B?VWJZeGhZdXJtSzkydG1ac01KaUZGbnhpV1F4QUszYVNiT09sNmJaNmQ4TGFi?=
 =?utf-8?B?cWhtcnYyUnlxWHpOS3NUbGhEd05pV3lsV3htZjNGN1lWV3U1cTRnV1F0cUlI?=
 =?utf-8?B?OEVhdFp3YmtoK2g2M3BpbXgrM0tiN2ZkR0lxRWxmYXZ6MEpxeW1STUpiUFdU?=
 =?utf-8?B?MlZEY1ByU1JpcWpXcml2eEtNNy8zNGVaVFZFbGQ5L3kwTU5QQWtUcUVKZnIr?=
 =?utf-8?B?Z1pmZ2M2aDlKNnowT3h1bTFJQzg1Zm0xRDNKT1J2OXlzZmI0b2JheWJRb2ht?=
 =?utf-8?B?cDdSSHBNaEVyb3hMdmt0c0FOeGV3NEhyY1dhVDB6Rk9kOTB3SVRYSGZwVFRK?=
 =?utf-8?B?VTV5T1I4U2FEUVdTbjJlZkU5OXViY1FKaWl1T2QvL2cwRUlaYTBBZkFvc1J6?=
 =?utf-8?B?ell4UzBndXp1YVVLam44Vm1MVjdySmtyT2dXTDhEU0ZSSEV0b3RJSEw0NUpJ?=
 =?utf-8?B?d3VoaFFpT0xHVVZRY0xYb3NGMlFCU2V5VXV4VTA2WWxUTFNoZUIwbXZkc1By?=
 =?utf-8?B?SWNWRmRZMjlvMW96TCswQlRSemlvM1hRN3ErNWZZSHdvb2ttY2xNalNPOEFN?=
 =?utf-8?B?YW9PeTFQT3pHbGU4TE1qMDlvTU5IUld6OHc4dGQ1d0FNVWh6UTh5RURPRTBM?=
 =?utf-8?B?ZkY2U21FTmEwdTErRmlFZHdTVkhJa1dOWU9EdEUyU1lQd3pZVFJlc3J0ckRT?=
 =?utf-8?B?NklMOS8xcWpVYStEbWMvR3dPRkhXWGpHTTZOaEsxVW5zaWdQZnZKWVNTWVNX?=
 =?utf-8?B?VmxYZ3BYaVdyalI5WUVjT25BWm5rUnl5a2IrTE5xZFNBNjFNd0ljRHlwWitt?=
 =?utf-8?B?WURPMGNlZmlGTFVoZjJVMFJqOTR3TGZFZFZMTU9Cc0Q2ZWtYWWpQd1ZsM3hW?=
 =?utf-8?B?NjhHanNwNW5ZbWNPeFQwY2lqTmdhMzQza1JiSG1WOVJRQXhVRFdwWlpIcHFO?=
 =?utf-8?B?VUFyL1lNT1IwTEIwL1hKcXlVaVNPeCtZSS9uYy9ycVhiVWVlVmFzKzEzdVAx?=
 =?utf-8?B?KytBbWNKUjhTTmYyci9FNHFtTjFwbWlFOEhKR2pwMGMzYW1XWDEzclBDTmxL?=
 =?utf-8?B?N3IwNmtQM0dOUG5PeTU3aFk2by90ME1FVXRwekFGUWlhT05EYjVSZXpSb2Ex?=
 =?utf-8?B?UFZFaTZtbkpVcllreFdrUFk5STFWVlV6cW56dkJHMWdUN1lzenlxQzIvOEhH?=
 =?utf-8?B?dmw4OThVeGZ3UjhoWlBZMnU1VjY5aEVZZkxsUHJsMnhnaFVkVjZBUy94bkU3?=
 =?utf-8?B?S1NCb3N5M0tlczNvVXBNdDhkR3dzZDBtcktKOTVUQ0xHS1l6a0F4TjNyOW16?=
 =?utf-8?B?SFN5QzdxMWIydjNlRnE5UWU3V3QvVG40M2RhelhtWXliY3I3eG1PUVd2ek9m?=
 =?utf-8?B?eE1MK0hscVJlakdVa0NZUWp5R2xmQ1NESTZMUHBIc2lPYWpOcFJkRGNSbGRv?=
 =?utf-8?B?UEFQT3V1WmYrUGpXUTRIZWZmS3BpeFkzb0t0NXY5ZytVN05wTEdaY1Q5YitV?=
 =?utf-8?B?VmdwaEJIV1dUYTJ1UkYzTUQvbm5ydU5zdnYxcW80TlFzeDBXcnJlNmh3aUhN?=
 =?utf-8?B?WU5rL1N2ZlZwZTdWY2RUaU5JVUNPSElqK09iVkJuU2hxWlpidXNLcFhyaXcw?=
 =?utf-8?B?Wm9jVUF1WnFFVmtMbGw4UnZWK1piSHV2eVN6aGNzaEFiMVFoWTZvTGViNFgz?=
 =?utf-8?B?YkZhUnQ2ZUo0VGRZdmFHRXd0c2c4OGVnSDZ2WWkvcHQ5OGRjSzdCNFRaRkVV?=
 =?utf-8?B?V0g0RC9UYUhWVS8xRUdqRUlxRU50aHdTUTVmYnR1WC92TDVraHpYL1JNNlRm?=
 =?utf-8?B?dTNrdy9oQitWbVdDYzlQTmNib1FSYUJxVXUxN0ZDLzFNSVlFVTFMMzJ4SW9I?=
 =?utf-8?B?WEpkK0lBK0x6S1FTRkNlNmlVNVlvZHJJUkpJWGFob3V0WHl2aUFaQWtneFVL?=
 =?utf-8?B?RFNtVklJNVhmTFVnRExGYS9RYUVCMkxROVE5WGNXTkpNamFwbkdYQnRIbjha?=
 =?utf-8?B?dlJSN2tIZ2N6ZzN1N2VpZ1YxMGV3L2hMZ3BFNENteCtyUDZza3JGMGIzTXla?=
 =?utf-8?Q?4VsFHl80fCFSKQEvWyEUWLI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf3b062-a546-4c20-0e58-08dc685cf281
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 14:59:19.4490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iagqFuh2DPysZ9FdZWhhhehlEn6oUU25UCHmQOg2b1Uksmjh8I8P7X17M/M801vi/8TnoFsyDb4MyBo4zqxo27l3kldrH2Lx63tahz6pqy5UQZ5Q4nYOXAj/AIpHkOwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 14:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15781

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBK
YW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6IE1vbmRheSwgQXByaWwg
MjksIDIwMjQgNzo0OCBQTQ0KVG86IGJhbGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCBURVVS
KSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQpDYzogcXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTsgZmVsaXgubW9l
c3NiYXVlckBzaWVtZW5zLmNvbTsga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgVE1J
RUMgT0RHIFBvcnRpbmcpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBh
c2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+
OyBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1
bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt
77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkgPGthenVoaXJvMy5oYXlh
c2hpQHRvc2hpYmEuY28uanA+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3Jl
XVtQQVRDSCB2NCAzLzNdIGRvYy9SRUFETUUuc3d1cGRhdGUubWQ6IFVwZGF0ZSBzdGVwcyB0byB0
ZXN0IERlbHRhIHNvZnR3YXJlIFVwZGF0ZQ0KDQpPbiAyOS4wNC4yNCAxNTowNSwgQWRpdGh5YS5C
YWxha3VtYXJAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gDQo+IA0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29t
Pg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI5LCAyMDI0IDY6MTUgUE0NCj4gVG86IGJhbGFrdW1h
ciBhZGl0aHlhKO+8tO+8s++8qe+8sCBURVVSKSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10
c2lwLmNvbT47IA0KPiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogcXVpcmlu
Lmd5bHN0b3JmZkBzaWVtZW5zLmNvbTsgZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbTsgDQo+
IGt1bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSANCj4g
PFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47IGFzaHJpdGggc2FpKO+8tO+8
s++8qe+8sCkgDQo+IDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+OyBkaW5lc2gga3Vt
YXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSANCj4gPGRpbmVzaC5rdW1hckB0b3No
aWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSANCj4g
4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFzaGlA
dG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCB2NCAz
LzNdIGRvYy9SRUFETUUuc3d1cGRhdGUubWQ6IA0KPiBVcGRhdGUgc3RlcHMgdG8gdGVzdCBEZWx0
YSBzb2Z0d2FyZSBVcGRhdGUNCj4gDQo+IE9uIDI1LjA0LjI0IDExOjQ0LCBBZGl0aHlhIEJhbGFr
dW1hciB3cm90ZToNCj4+IFRoaXMgY2hhbmdlIGluY2x1ZGVzIHN0ZXBzIHRvIHZlcmlmeSBEZWx0
YSBTb2Z0d2FyZSBVcGRhdGUgd2l0aCANCj4+IHJkaWZmX2ltYWdlIGFuZCBkZWx0YSBoYW5kbGVy
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdGh5YSBCYWxha3VtYXIgPEFkaXRoeWEuQmFsYWt1
bWFyQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICBkb2MvUkVBRE1FLnN3dXBkYXRlLm1k
IHwgNTkNCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Rv
Yy9SRUFETUUuc3d1cGRhdGUubWQgYi9kb2MvUkVBRE1FLnN3dXBkYXRlLm1kIGluZGV4DQo+PiBi
N2UxM2Y3Li5kOTU1ODY4IDEwMDY0NA0KPj4gLS0tIGEvZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0K
Pj4gKysrIGIvZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0KPj4gQEAgLTM2MCw2ICszNjAsNjUgQEAg
dXNlciB2YXJpYWJsZXM6DQo+PiAgDQo+PiAgYGBgDQo+PiAgDQo+PiArIyBCdWlsZGluZyBhbmQg
dGVzdGluZyB0aGUgQ0lQIENvcmUgaW1hZ2UgZm9yIERlbHRhIFNvZnR3YXJlIFVwZGF0ZQ0KPj4g
Kw0KPj4gK1NldCB1cCBga2FzLWNvbnRhaW5lcmAgYXMgZGVzY3JpYmVkIGluIHRoZSBbdG9wLWxl
dmVsIFJFQURNRV0oLi4vUkVBRE1FLm1kKSwgYW5kIHRoZW4gcHJvY2VlZCB3aXRoIHRoZSBmb2xs
b3dpbmcgc3RlcHMuDQo+PiArDQo+PiArRmlyc3QgYnVpbGQgYW4gaW1hZ2UgdXNpbmcgdGhlIGZv
bGxvd2luZyBjb21tYW5kOg0KPj4gK2BgYA0KPj4gK2hvc3QkIC4va2FzLWNvbnRhaW5lciBidWls
ZA0KPj4gK2thcy1jaXAueW1sOmthcy9ib2FyZC9xZW11LWFtZDY0LnltbDprYXMvb3B0L2ViZy1z
d3UueW1sOmthcy9vcHQvcnQuDQo+PiAreQ0KPj4gK21sDQo+PiArYGBgDQo+PiArVGhlIGFib3Zl
IGltYWdlIHdpbGwgYmUgdXNlZCBhcyB0aGUgYmFzZSBpbWFnZSB0byB3aGljaCB0aGUgdXBkYXRl
IGlzIGFwcGxpZWQuDQo+PiArDQo+PiArIyMgRGVsdGEgU29mdHdhcmUgVXBkYXRlIHVzaW5nIHJk
aWZmX2ltYWdlIGhhbmRsZXINCj4+ICsNCj4+ICtDcmVhdGluZyBhbiBkZWx0YSB1cGRhdGUgZmls
ZSBmb3IgcmRpZmZfaW1hZ2UgaGFuZGxlciByZXF1aXJlcyBhIHJlZmVyZW5jZSBhcnRpZmFjdCAo
YWdhaW5zdCB3aGljaCB0aGUgZGVsdGEgaXMgY29tcHV0ZWQpLiBJbiB0aGlzIGNhc2UsIHRoZSBp
bWFnZSBidWlsdCBpbiB0aGUgcHJldmlvdXMgc2VjdGlvbiBjYW4gYmUgdXNlZCBhcyB0aGUgcmVm
ZXJlbmNlIGFydGlmYWN0KC5zcXVhc2hmcy8udmVyaXR5IGZpbGUpLiBTZXQgdGhlIHZhcmlhYmxl
IGBERUxUQV9VUERBVEVfVFlQRWAgYXMgYHJkaWZmYCBhbmQgc2V0IHRoZSB2YXJpYWJsZSBgREVM
VEFfUkRJRkZfUkVGX0lNQUdFYCB3aXRoIHRoZSBuYW1lIG9mIHRoZSByZWZlcmVuY2UgYXJ0aWZh
Y3QuIFRoZSB2YWx1ZXMgb2YgYERFTFRBX1VQREFURV9UWVBFYCBhbmQgYERFTFRBX1JESUZGX1JF
Rl9JTUFHRWAgY2FuIGJlIGNoYW5nZWQgaW4gdGhlIGBzd3VwZGF0ZS55bWxgIGZpbGUuDQo+PiAr
DQo+IA0KPiBDYW4ndCB3ZSBlbmFibGUgcmRpZmYgYnkgZGVmYXVsdCBzZXQgREVMVEFfUkRJRkZf
UkVGX0lNQUdFIGZvciBvdXIgb3duIGRlbW8gaW1hZ2U/IEkgZG9uJ3Qgd2FudCB0byBoYWNrIG9u
IHRoZSBjb2RlIHRvIHRyeSB0aGluZ3Mgb3V0LCBhdCBtb3N0IHNlbGVjdCBhbiBvcHRpb24gaW4g
dGhlIGtjb25maWcgbWVudS4gDQo+IA0KPiBbQWRpdGh5YSBCYWxha3VtYXJdDQo+IEhpIEphbiwN
Cj4gDQo+IEkgd2FzIGNvbnNpZGVyaW5nIHRoaXMgYXBwcm9hY2ggYXMgc3VnZ2VzdGVkIGJ5IHlv
dSBoZXJlLiBCdXQgd2hlbiByZGlmZiBpcyBnaXZlbiBhcyBhIGRlZmF1bHQgb3B0aW9uIGFuZCBp
ZiB0aGUgbmVjZXNzYXJ5IGFydGlmYWN0IHdhcyAqKm5vdCoqIHByb3ZpZGVkIGF0IHRoZSBleHBl
Y3RlZCBsb2NhdGlvbiwgdGhlbiB3ZSB3b3VsZCBoYXZlIHRvIGZhbGxiYWNrIHRvIGNyZWF0ZSBh
IGNvbXBsZXRlIHVwZGF0ZSBzd3UgZmlsZS4gSXQgY291bGQgY2F1c2UgYSBjb25mdXNpb24gZm9y
IHRoZSB1c2VyLiANCj4gDQo+IE9yIG1heWJlIGhhbmRsZSB0aGUgYWJvdmUgc2l0dWF0aW9uIGJ5
IGEgd2FybmluZyBtc2cgdGhhdCB3ZSBhcmUgZmFsbGluZyBiYWNrIHRvIGNyZWF0aW5nIGEgY29t
cGxldGUgc3d1IGZpbGUuDQo+IA0KDQpJZiB3ZSB3YW50IHRvIGVuZm9yY2UgdGhlIGV4cGVjdGF0
aW9ucyBhbmQgZGVsaXZlcmFibGVzLCB0aGVuIHdlIG5lZWQgdG8gcHJvdmlkZSBhdCBsZWFzdCBh
IGthcyBvcHRpb24gZmlsZSB0byBlbmFibGUgdGhpcyBtb2RlLiBJSVJDLCB3ZSBjYW1lIGZyb20g
dGhlcmUsIGFuZCBJIGFza2VkIHRvIGF2b2lkIHRoYXQgOikuDQoNClNvLCB3ZSBhcmUgY3VycmVu
dGx5IGdlbmVyYXRpbmcgb25seSBvbmUgU1dVLCBhbmQgdGhhdCBpcyBlaXRoZXIgYSBmdWxsIG9y
IGEgZGVsdGEgaW1hZ2UsIGRlcGVuZGluZyBvbiB0aGUgY29uZmlndXJlZCBtb2RlPyBXaHkgbm90
IGdlbmVyYXRpbmcgYm90aD8gTm90IGVhc2lseSBleHByZXNzaWJsZSBpbiBvdXIgY3VycmVudCBj
bGFzc2VzL3JlY2lwZXM/DQoNCkphbg0KDQpbQWRpdGh5YSBCYWxha3VtYXJdIA0KDQpIaSBKYW4s
DQoNCkFwb2xvZ2llcyBmb3IgdGhpcyBiYWNrIGFuZCBmb3J0aC4NCg0KWWVzLCBjdXJyZW50bHkg
d2UgYXJlIGdlbmVyYXRpbmcgb25seSBvbmUgU1dVIChkZWx0YSBvciBjb21wbGV0ZSkuIEFuZCB0
aGlzIGFwcHJvYWNoIHdhcyB0YWtlbiBiYXNlZCBvbiBmZWVkYmFjayBmcm9tIHYzLiBMaW5raW5n
IHRoZSBkaXNjdXNzaW9uIHRocmVhZCBoZXJlOiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9y
Zy9nL2NpcC1kZXYvdG9waWMvMTA1NTMzMTcwI21zZzE1NTYxDQpVcCB1bnRpbCB2MywgdGhlIGlt
cGxlbWVudGF0aW9uIHdhcyBmb3IgY3JlYXRpbmcgY29tcGxldGUgdXBkYXRlIHN3dSBhbmQgYSBk
ZWx0YSB1cGRhdGUgc3d1IChpZiBhbiBhcnRpZmFjdCB3YXMgcHJvdmlkZWQgaW4gYSBzYWlkIGxv
Y2F0aW9uIGFuZCBwb3NzaWJseSBiYXNlZCBvbiBvdGhlciBjb25maWdzKS4NCg0KUmVnYXJkcywN
CkFkaXRoeWEgIA0KDQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENl
bnRlcg0KDQo=


