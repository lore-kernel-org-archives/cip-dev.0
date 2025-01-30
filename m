Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9A3C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:29:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.11952.1738229343878781545
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:29:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 50U9T1Vj349719; Thu, 30 Jan 2025 18:29:02 +0900
X-Iguazu-Qid: 2rWhqikycUxWsze3Ax
X-Iguazu-QSIG: v=2; s=0; t=1738229341; q=2rWhqikycUxWsze3Ax; m=ETDV5VEx5L63xuiNodxPE37op8ESzJoa1F76Sgls2G4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 50U9T0Mf1190098
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 18:29:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wV0HFvtjY+N5LmNMvfv3tSW2bUXprTIJbvm86l7xt4NOmcZI01UFJDRFqlR+MH7s2aTKf/N/qYRaN9bjfzJavcB2Hpzb2eoG0Fq+pWRoSCe55TASf1CE9J6yGE34U4mz0ytW9/XivEaYW8aOI92wny3FAyzew4+v4Zhjw5TT8nbn89g21wTkGF9YjyJSX2K7XoXENlFnDPjxQJ5q03RH0onH8G2qKH1OpE3fvb0vPsE8bqiqqiahHYVeMjG7nCfeWcsbmJ+wUYlYB+INCjlyRBsmtoALm+8gYbBLN2E0L/69DEfzf1/TE5rqXGNSYp/BJeiIN1eFMeJzj+sSTUndCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAIi8NIYI7vUHXdEBUTzfJEpQPbCn7urnXbsHDixUOo=;
 b=xKu1NLdzH2M/mzZrAMHhqftanULw1GJjTNDMKP+jsYWCFZqonxTHY1SFe6wdjU8Xshwg4j4CXz7VGDlBLo+y+3ukjVnkcXCtO/cEYuiu5H/Q4TuGK8P45DfNh5Io94gLqJqbInThhT2lVCIRSHh9+x6FIs59sylFSENdBrse0SbNhNBIWCKlykjvJzzpCeTHgPGdgoP04YY5Vq8Bil2ugRQ8fR4y6qc0bjD+Ptbnp96Gh4c+iS5orq3Xd4Ye6+PxMrgTdA3DvaOoWYduSYzsU5HUJNxpADs94xpgxjslzphcGsPghw3Zzk26RPZtocjgwPq/ck0hkPDEsjBnkqeJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
CC: <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security:
 add curl to download LAVA overlay
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security:
 add curl to download LAVA overlay
Thread-Index: AQHbbmMZtzjdjBI/2kaUtODthJ5QdrMvCeIzgAAF54CAAAC14w==
Date: Thu, 30 Jan 2025 09:28:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103A66703C3CAE0FB077BC9C2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-4-Quirin.Gylstorff@siemens.com>
 <OS3PR01MB61036828512A1860892182A5C2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <dbdeebd3-056d-4cb9-894c-543fefc01c6c@siemens.com>
In-Reply-To: <dbdeebd3-056d-4cb9-894c-543fefc01c6c@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6100:EE_|OSZPR01MB7795:EE_
x-ms-office365-filtering-correlation-id: 5621970b-bc7d-4eb4-e6ef-08dd41108611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WmtGYXY2QUxFNGRGQ1hVcmRJQ25oem9lRG9NU0hMQStzaDdsMGZuWk95?=
 =?iso-2022-jp?B?SGl3eTdIQk9mZHJ4ZlhkOForVitCdTVIdEFjbzVjUW5lY09xWGo1UGFq?=
 =?iso-2022-jp?B?djgvWWp2ckNDcTRlTkFWeDY2cFFpeVUwOEFHREpEVFVMKzJMNTVkV2Nh?=
 =?iso-2022-jp?B?bVVEdFFRZlVOdU5IMjRLbEp2Z2RmaVNrbWNRNzVWNTVvZUlXbStwNk1R?=
 =?iso-2022-jp?B?ZDFCdlNtQjUrZFROTDd1dU9NVVVCUmRISk10dldkblRPeXcyVjVUQ005?=
 =?iso-2022-jp?B?bVZvV1VIaXZqTG4yWEgrMzlQaDlYNmQ5RVF4YnNoWktqWVI1a0FRRDVn?=
 =?iso-2022-jp?B?K3pmM2M4QlEyM296cHFhZWhBd1NxdEJWZG1mK0Q1clFFeFNKUHk1NHBT?=
 =?iso-2022-jp?B?UHFoS2RuMjJzV0FDUVlGOGh4Y2ovdGhuTlZCUmNvS09HdDhnc0VDcm9z?=
 =?iso-2022-jp?B?KzVzVXQzdWxneXMxc3R2ZEd5eW1xVko0VkVBUzJXU2hEc2l4d2Q4R0xJ?=
 =?iso-2022-jp?B?SUhQVzZXckhvbzJEU2g5ZGFJa2VyT1FCSFBvV3Nod3dKZG0rT2ZQK2xw?=
 =?iso-2022-jp?B?V3ZHTS9JZmhWR3FQYWlBVlFwL2hBQ2UxMWVxa2JXNGhCc3ZDZTQ0c3B6?=
 =?iso-2022-jp?B?eGYxcHVXNUtNcXo0bXRWbk9pZUNBTjNiUVBlVlhURXFxVGN6YXN1SVR4?=
 =?iso-2022-jp?B?andUZDg5dVhQQXpyT3pUak1sYTF0Skg0TXMzU08yU2F1ZEJzRUxMRCta?=
 =?iso-2022-jp?B?R2MyOG5zalVTWStiVTl2c0ZMZjhYeDUxTDlxcGRabGpkYTQ2VndTWElV?=
 =?iso-2022-jp?B?cFdIbFErUHBGdm9zMCtzT3Nlb0E5ZE5vYWE5eWR3UzJGRHUzcDVMNUlo?=
 =?iso-2022-jp?B?Z2NTOUppSTU4bkh4K3pPT1ZGNGl3Z05lUlEvZmZKcjRjeXZjaWtFcmJq?=
 =?iso-2022-jp?B?U2pHYUpKU3BabC8zeVJWa1VKaDdVUFNVeVcyTTYyeDFJSkxBSmd5OUla?=
 =?iso-2022-jp?B?WlVJU29vUitNZGx3eFl5OWVNYjlnSzhia0w5UmFTb0pwREVxQ1RCVC9S?=
 =?iso-2022-jp?B?c3pRWTE1MlFScTdROG10N0F2R0FETktqMXJ3TTIzTXlzRVF1YlM2K004?=
 =?iso-2022-jp?B?VUQ2QzNrQitQSDBoc0tEdi9reHV3R200KzIvekZ1eE5VQnZmejFCQTZ2?=
 =?iso-2022-jp?B?OEtITE14UlUyUEk0Y25HQnJsOEFESU5DS2pqZjhpaW9NdE5iamNXRjFi?=
 =?iso-2022-jp?B?elc4b0padzJndGxtM0c0cjZZbkhJVXRUWG5PT3hnejlwSDdkTlcrNS9n?=
 =?iso-2022-jp?B?aUxQUEQ4V1F6VVRQQ29lblE2UURDZ0dVOUwyT1VRUE4wQzFsWDRsaGVJ?=
 =?iso-2022-jp?B?dTdGbytyYmc2dm9ucUdxWmNoNkJURFhuMGZ3bFVtMTY3TXl4VHhGTWM1?=
 =?iso-2022-jp?B?MnpaYUhxRGZ6UVQ4S2FyNVVzU09vNmYrM3FWUzBkOXJPS1E5a05xckht?=
 =?iso-2022-jp?B?dUNYQ2d3c3F4VWgwWkFsV0hmWlp3UHZUb1VvWEhXaUcyRDBhclBMT1lL?=
 =?iso-2022-jp?B?QUdhOWk0Q1M1R3BJMWN0V0R6aGI4VjRTYk4xL1VjTmVCSGFEL25STElp?=
 =?iso-2022-jp?B?NXFLOWdyNkF2QkVBTlF6a1pQVXBtdEhPTE4yUWhuTmdrT3JCUzNBbzBC?=
 =?iso-2022-jp?B?R01zU3Yvc2NIWjlYOW16QXlJNG1kdjRLWi9TY2VhWktEUE1mTmgzVlVF?=
 =?iso-2022-jp?B?aVJwRmY1RFU3MGM2d3R0b0xMODVUOVhLbVp2MzVVcnUvUlBYM09BSkJ0?=
 =?iso-2022-jp?B?TmNpdlYxb01WZUl3S0hhNWs2elV6SUZOenNCdFZObEZRL3dMVndmS3lD?=
 =?iso-2022-jp?B?RFZZT0FPRVF5TWtsNG1CVkM3UnQ1WXJhMmNsZTVkcG91UDhseU9ITzlE?=
 =?iso-2022-jp?B?am1NWDNxNTFUQ2JPUEpxMHptUUdhT0FOYldXT3NkZkFJbHNkbVhRcXVM?=
 =?iso-2022-jp?B?THhTZWNGTk9aUmZLNmR1N3k1aDdZdW9GTi9LOXNOTk1aMEFCUmVFTy9Z?=
 =?iso-2022-jp?B?UEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dmM1OWJDZ2daaEN3QTZnL3ErdGR5SWxHNDk2a01wTzMwbXZPaFlFeG44?=
 =?iso-2022-jp?B?dlFidmo0eHBrYUxML3N0U3pyeU04alNEY1BJeGZxNVlxek5GaTMweG9u?=
 =?iso-2022-jp?B?WmJjYTVEQmZzLy9RUUsyb05RaUFJQ0RrWGVWejIvL1pMVzVlOU5Ody9K?=
 =?iso-2022-jp?B?elRpalpXRmcrb04zdGduSVE1RXFZT2wwWVJLdlAraHo0RXQyUXJsRm5w?=
 =?iso-2022-jp?B?UG9mVC9oanc5QmZhSE1LOFI1Wkx3K1o4WHA3V0EvYWdwTjF4WStUZjhu?=
 =?iso-2022-jp?B?Y2drYVdlakFpY2FtMXVwVTN0b1g0SjVIR2RDWlhpVkwyYVViYUtEN0tJ?=
 =?iso-2022-jp?B?WDlKeitySDNMUGYxZ3BjNUp5Y2E0Nmg1OWFNaFpDTldFbnMveDdOYkhV?=
 =?iso-2022-jp?B?bS9nQzRocDdEb2krNDhFMVlPZXRXVDdPY2FEZ2FKKy9kYTJUOWV4VEM4?=
 =?iso-2022-jp?B?V1FnK2ZNaVFFYVRvOU5uTDlmSVQwWkF2RGJCd2RhU1A1TW14TEoxYWZu?=
 =?iso-2022-jp?B?MGZ2WjhQV3cvZ09jMy91czJjaDJGZ2UxS3YxMkJLUzJ6bHZ5TWlIMGR5?=
 =?iso-2022-jp?B?cytwRk5CSEVnK0t5MnlLNlhNcGhpY0RLTzdnTGw5UmRCMyt3TDlrNWt4?=
 =?iso-2022-jp?B?dnFPSnU4VG5zMHZ5c1ZTV2xaQWZic2V3azRMZS9tVjBFdWs0VVJJeEFp?=
 =?iso-2022-jp?B?Wjc4UmRSRWVxcktraEx5WjAvaTVGbi9QRlpLWHE1cTFJSFhpckkva3Fa?=
 =?iso-2022-jp?B?cGZ4YjI0TWVHckV3Ym5wN2gvWjM5ZGhZeWFLQkVxeUxXQjdzMFN6M1NC?=
 =?iso-2022-jp?B?dHR2cEhYdytlTklibVNIUzhIWnlJQ0xjMWl3dnU4RmQrczQxc2g1N0FW?=
 =?iso-2022-jp?B?Z1FpNDRzeUVjanFCa1d4L0R6RjB5Yy84NGlPQmdGRklxbFA5MlJxem1Y?=
 =?iso-2022-jp?B?bE9tN2VEV08zZmRwWm9CUnhXR3E3RXZLc1FMY295cGwzb1NidS84UGV6?=
 =?iso-2022-jp?B?OHFhWkJKNjJsSTdkN283V1ZPd3BNaExQbHRPamYzTGVZZE5NNDJmRllP?=
 =?iso-2022-jp?B?dEtTWnJIUjdWSzRRb2tFT1RnNUFHTXlxd05tQVhEN2NZZ1Y3Tk1PRDAx?=
 =?iso-2022-jp?B?bDlUWDRWQlpHYld2ZXNlSUgrQ1h1emc3Y2FJWEtBTGVDSzRxbmxKODBK?=
 =?iso-2022-jp?B?c3FSaS9QWkVoU1o1NmlKOXF5SCthR0Y5STNOdW9oL1IvRHU1eDY4YWdl?=
 =?iso-2022-jp?B?U1ZiQkVTbFFrMnRMTjNIVjN3Q2QySTZMNlZBcGN5ZVhUN2FhdTdlUWEy?=
 =?iso-2022-jp?B?YzBNTlR4U0F5Tm9UMnI0b3FzR2hhN3lndzR5YnFFVE8vS2ZBd0V2RUtH?=
 =?iso-2022-jp?B?dFF4R28vNkZ0SVgzWUZPNDdzQzExQ1lBckxYN1pNV2dFU3RRc2V3RWYy?=
 =?iso-2022-jp?B?VkFKS2hQclY0WkNFNFBSVjlQTTRjK1Q0VmFBenl4emVsZkhxUExGZkpi?=
 =?iso-2022-jp?B?WFlKM2pEWHJHdjNJLzhTY2kzNjBJanpvbnVJUUxvMFUrY3hTSU11a0d3?=
 =?iso-2022-jp?B?OTNIaHVmbjRuQ0R6ZFNoQTlZZmZhdG95YVR6RkxCczd4NFZZUWVKMkds?=
 =?iso-2022-jp?B?Qk9mNG9kdzVpSzgxWHNJdkFRUnB5bk11ekxpbWhMY0hYdGs1T2htbjdo?=
 =?iso-2022-jp?B?ZjlWWVlVTi9WYmxFcnMrOGNKYUJqenNtQ2dCM3Jmc2NML21HRHkyZXVl?=
 =?iso-2022-jp?B?VTRJUG9vaks4Z1prRnBHdVRzSmFwbjJPUmRUSDl6QXRlM2FxdDlLZE5h?=
 =?iso-2022-jp?B?L05Xdzh0UDQzY3B5YXh5enNqNzJwVmZpYnFjVWNOVG9OUU9lRWdWdGlq?=
 =?iso-2022-jp?B?MG1mcTdYRlhzdmhhZXROUVIyRmpFbWtSQ2dmOVNIc1pNdGFadFRtZDNT?=
 =?iso-2022-jp?B?Yi9yRW1HMVhaSGpFdTlMSTNLOE92ak1JNGd1VnZjOCtQM0NzZ0pJc3Vx?=
 =?iso-2022-jp?B?UUE3dnI2Zm80elNkWDJqTS9TbzZTWHhHWlFYUlR1Uk52b3dib2hOR2hL?=
 =?iso-2022-jp?B?NlNnWWx6M3R0NTNUdm1GU1B0alVGTUpXdlhGSUxKcDJVd2tVeVhERzd6?=
 =?iso-2022-jp?B?b0dReWlhLzRWd0hXYkNENXJWVnE1NkUwY0VqMEJERkRuaEZZNk1JRERv?=
 =?iso-2022-jp?B?dkZtbFBpbHZ3c1BsdHYwZml6NElUYmVtbEF3Qmwrc0EzVDhWZG11b0lv?=
 =?iso-2022-jp?B?ZmZRU21kTFdEUitudHhhK1UwWXBXQjAvZUtPRkhKR2V2SXNaMUVhNDJF?=
 =?iso-2022-jp?B?VVpIQkVlT2tVQW5qVTFPSGIzZkwrUUtzdVE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103A66703C3CAE0FB077BC9C2E92OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5621970b-bc7d-4eb4-e6ef-08dd41108611
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 09:28:58.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaaMyYb0r4IwedScLN56yVMKAg+f7kLmZusGY/8B4oTIcOTB2B35ci5f/f6v4iJCfuz9XRcBad/VvdCBM5+HIPt8pX9kNIy9AMHjBLWIB88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7795
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:29:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17695

--_000_OS3PR01MB6103A66703C3CAE0FB077BC9C2E92OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

I think dropping '-test' itself can affect pure test targets like build:qem=
u-amd64-test, build:x86-uefi-test etc. The user cannot know what kind of ta=
rgets they are without a '-test' at the end of the artifact's name.

Regards,
Sai Ashrith


________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Thursday, January 30, 2025 2:36 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: jan.kiszka@siemens.com <jan.kiszka@siemens.com>; cip-dev@lists.cip-proj=
ect.org <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security=
: add curl to download LAVA overlay



On 1/30/25 09:52, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Quirin,
>
> Including test extensions to security shall make the artifact name cip-co=
re-image-security-cip-core-bookworm-x86-uefi-test.wic. So, the artifact's u=
pload to s3 shall fail<https://gitlab.com/cip-project/cip-core/isar-cip-cor=
e/-/jobs/8943849473#L2128> due to current logic mentioned here<https://gitl=
ab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-=
core.sh?ref_type=3Dheads#L22>.

Do we need that `-test` or can we drop it?

Best regards,
Quirin
>
> Regards,
> Sai Ashrith
>
> ________________________________
> From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
> Sent: Friday, January 24, 2025 6:52 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; jan=
.kiszka@siemens.com <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org=
 <cip-dev@lists.cip-project.org>
> Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security: =
add curl to download LAVA overlay
>
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>
> Lava generates an directory, in LAVA called overlay, which contains
> all scripts and tests of the test stage. The Device-under-test
> needs to be instrumented with with this overlay.  LAVA provides the
> possibility to download the overlay via http or NFS. We use curl
> to download to the overlay from a http server.
>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml   | 3 ++-
>   kas/opt/test.yml | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 686ce48..d63ef2e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -65,6 +65,7 @@ default:
>       - if [ "${release}" =3D "trixie" ]; then base_yaml=3D"${base_yaml}:=
kas/opt/trixie.yml"; fi
>       - if [ "${encrypt}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:=
kas/opt/encrypt-data.yml"; fi
>       - if [ "${watchdog}" =3D "disable" ]; then base_yaml=3D"${base_yaml=
}:kas/opt/disable-watchdog.yml"; fi
> +    - if [ "${test}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:kas/=
opt/test.yml"; fi
>       - if [ "${swupdate_version}" =3D "2022.12" ]; then base_yaml=3D"${b=
ase_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>       - echo "Building ${base_yaml}"
>       - kas build ${base_yaml}
> @@ -250,8 +251,8 @@ build:x86-uefi-secure-boot:
>       extension: security
>       use_rt: disable
>       targz: disable
> -    encrypt: disable
>       watchdog: disable
> +    test: enable
>
>   build:qemu-amd64-swupdate:
>     extends:
> diff --git a/kas/opt/test.yml b/kas/opt/test.yml
> index 4a60ad4..b23f437 100644
> --- a/kas/opt/test.yml
> +++ b/kas/opt/test.yml
> @@ -17,3 +17,6 @@ local_conf_header:
>       IMAGE_PREINSTALL +=3D "rt-tests stress-ng"
>       DESCRIPTION:append =3D " with test packages"
>       IMAGE_FULLNAME:append =3D "-test"
> +  lava-testing-add-curl: |
> +    IMAGE_PREINSTALL +=3D "curl"
> +
> --
> 2.47.0
>


--_000_OS3PR01MB6103A66703C3CAE0FB077BC9C2E92OS3PR01MB6103jpnp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think dropping '-test' itself can affect pure test targets like build:qem=
u-amd64-test, build:x86-uefi-test etc. The user cannot know what kind of ta=
rgets they are without a '-test' at the end of the artifact's name.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Quirin Gylstorf=
f via lists.cip-project.org &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-pr=
oject.org&gt;<br>
<b>Sent:</b> Thursday, January 30, 2025 2:36 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;<br>
<b>Cc:</b> jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;; cip-dev@l=
ists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> Re: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-s=
ecurity: add curl to download LAVA overlay</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 1/30/25 09:52, Sai.Sathujoda@toshiba-tsip.com wrote:<br>
&gt; Hi Quirin,<br>
&gt; <br>
&gt; Including test extensions to security shall make the artifact name cip=
-core-image-security-cip-core-bookworm-x86-uefi-test.wic. So, the artifact'=
s upload to s3 shall fail&lt;<a href=3D"https://gitlab.com/cip-project/cip-=
core/isar-cip-core/-/jobs/8943849473#L2128" data-auth=3D"NotApplicable">htt=
ps://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8943849473#L2128<=
/a>&gt;
 due to current logic mentioned here&lt;<a href=3D"https://gitlab.com/cip-p=
roject/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-core.sh?ref_=
type=3Dheads#L22" data-auth=3D"NotApplicable">https://gitlab.com/cip-projec=
t/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-core.sh?ref_type=
=3Dheads#L22</a>&gt;.<br>
<br>
Do we need that `-test` or can we drop it?<br>
<br>
Best regards,<br>
Quirin<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith<br>
&gt; <br>
&gt; ________________________________<br>
&gt; From: Quirin Gylstorff &lt;Quirin.Gylstorff@siemens.com&gt;<br>
&gt; Sent: Friday, January 24, 2025 6:52 PM<br>
&gt; To: ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.com=
&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;; cip-dev@lists.=
cip-project.org &lt;cip-dev@lists.cip-project.org&gt;<br>
&gt; Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-securit=
y: add curl to download LAVA overlay<br>
&gt; <br>
&gt; From: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
&gt; <br>
&gt; Lava generates an directory, in LAVA called overlay, which contains<br=
>
&gt; all scripts and tests of the test stage. The Device-under-test<br>
&gt; needs to be instrumented with with this overlay.&nbsp; LAVA provides t=
he<br>
&gt; possibility to download the overlay via http or NFS. We use curl<br>
&gt; to download to the overlay from a http server.<br>
&gt; <br>
&gt; Signed-off-by: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<b=
r>
&gt; ---<br>
&gt;&nbsp;&nbsp; .gitlab-ci.yml&nbsp;&nbsp; | 3 ++-<br>
&gt;&nbsp;&nbsp; kas/opt/test.yml | 3 +++<br>
&gt;&nbsp;&nbsp; 2 files changed, 5 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
&gt; index 686ce48..d63ef2e 100644<br>
&gt; --- a/.gitlab-ci.yml<br>
&gt; +++ b/.gitlab-ci.yml<br>
&gt; @@ -65,6 +65,7 @@ default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${release}&quot; =3D =
&quot;trixie&quot; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/trixie.ym=
l&quot;; fi<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${encrypt}&quot; =3D =
&quot;enable&quot; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/encrypt-d=
ata.yml&quot;; fi<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${watchdog}&quot; =3D=
 &quot;disable&quot; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt/disable=
-watchdog.yml&quot;; fi<br>
&gt; +&nbsp;&nbsp;&nbsp; - if [ &quot;${test}&quot; =3D &quot;enable&quot; =
]; then base_yaml=3D&quot;${base_yaml}:kas/opt/test.yml&quot;; fi<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - if [ &quot;${swupdate_version}&q=
uot; =3D &quot;2022.12&quot; ]; then base_yaml=3D&quot;${base_yaml}:kas/opt=
/swupdate-2022.12.yaml&quot;; fi<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - echo &quot;Building ${base_yaml}=
&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - kas build ${base_yaml}<br>
&gt; @@ -250,8 +251,8 @@ build:x86-uefi-secure-boot:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extension: security<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_rt: disable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; targz: disable<br>
&gt; -&nbsp;&nbsp;&nbsp; encrypt: disable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watchdog: disable<br>
&gt; +&nbsp;&nbsp;&nbsp; test: enable<br>
&gt; <br>
&gt;&nbsp;&nbsp; build:qemu-amd64-swupdate:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; diff --git a/kas/opt/test.yml b/kas/opt/test.yml<br>
&gt; index 4a60ad4..b23f437 100644<br>
&gt; --- a/kas/opt/test.yml<br>
&gt; +++ b/kas/opt/test.yml<br>
&gt; @@ -17,3 +17,6 @@ local_conf_header:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL +=3D &quot;rt-tes=
ts stress-ng&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DESCRIPTION:append =3D &quot; with=
 test packages&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_FULLNAME:append =3D &quot;-t=
est&quot;<br>
&gt; +&nbsp; lava-testing-add-curl: |<br>
&gt; +&nbsp;&nbsp;&nbsp; IMAGE_PREINSTALL +=3D &quot;curl&quot;<br>
&gt; +<br>
&gt; --<br>
&gt; 2.47.0<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB6103A66703C3CAE0FB077BC9C2E92OS3PR01MB6103jpnp_--


