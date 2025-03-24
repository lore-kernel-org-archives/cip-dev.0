Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5280BC36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 12:03:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.37616.1742817813204238278
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 05:03:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 52OC3UGU2324811; Mon, 24 Mar 2025 21:03:31 +0900
X-Iguazu-Qid: 2yAbpfLvGS4dw40PWS
X-Iguazu-QSIG: v=2; s=0; t=1742817810; q=2yAbpfLvGS4dw40PWS; m=egw7zpde0eQ8XNnopR6osK235uYGSWbx4+gmP74xlDg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 52OC3U2A3548646
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 21:03:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzis1TU56MnoPZLEf+FdPRSL0o41v5CjdgP6uf+u9MsMC1vWl0hN4z9Vu6DETeoWYvAvI+MROBRSpP0JPmSGZbnGx73ycXCISa6Xt+H8nUD+pgMpFN/Se4bTy4h5MxzeM9qXY3W9GCPDFsD96t5g479wr+3bXpWawaQX11lNSSoDHiMol5MhibPFW/6NnXi4JmwuZHR08qCXFlx9lnej7sWHWOMBCoSwHVrKBYWaU0atH+UGlTmViz7BtCq0B/V6ezwS+VHvxuTRwBkleoRTlqcJeG8YQVyt1+21yWdce5kWoE5ORc10BN8QF8qUGWzce44DFuHP45bdZ6HzDaDJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh+syKHCG6r6qISDSgUWDCec5IEDvaIN4nyn21oHOis=;
 b=NQd1TK8l4vbRwL57B3HegW/kXVxQNPLsdSScGxf9odpyHtbJVO8uv6RXJ+RIkR0+6reAKY/kft8CY8U6y0fkHNJ8zt+ZeoPPILuO/jx2Y897FRk89neiW93kaQ/NM8V4Ajf8k1jScwuYU3Qj6YANOG/PmYEve016kotvCGZ88fQNdFVaW2651BiB8dk2mM0JzPQ8KWmLtk4uChiCapcqEGyhm/ttL8Pi/mMNKPloJjUSxolxVlCu9ychg8o15NadNoXG7uiu/4YXl5097buh52SFqniiBBIBMjLYMdNjLXdxfXHvgPNfwtd6xywaqltkzGTZaZwlGIkn64oUozAscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partition
 for qemu security targets
Thread-Topic: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home
 partition for qemu security targets
Thread-Index: AQHbnK9nqUOYqApi7k2+41qxWTvRo7OCJlOAgAAAZmGAAAbbgIAAAP27
Date: Mon, 24 Mar 2025 12:03:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838F9000A2E15ABD469B47AC2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
 <37053ef1-be2b-442d-b4a9-9da99e75671f@siemens.com>
 <OSCPR01MB14838A47CBFE9609D5FF0D806C2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
 <a1270914-e11d-471d-a63c-77dddcb958cf@siemens.com>
In-Reply-To: <a1270914-e11d-471d-a63c-77dddcb958cf@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TY4PR01MB12751:EE_
x-ms-office365-filtering-correlation-id: c601b42f-21a2-46ad-d882-08dd6acbe361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003|13003099007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QVJuS1g1TC9ONm13U2hyVlUrNDFlWmtQZ050QXRUYVNvYitrWll2TWtV?=
 =?iso-2022-jp?B?M1RzRUtJQ29XeU4zbEh0cWlWMlB1L0hwVEg2OGhCSTVCNEdoU0V4ZVVM?=
 =?iso-2022-jp?B?bFJ6WDhndjcvQWk2WGFTTGZKVEpvTXBGaHhkMlFtR0tEMDZGenRMT0la?=
 =?iso-2022-jp?B?SzFlQnBjV0JhOWMzT3FTdXVJRXBvVmZpS0hCOXNRVnFZTFVzaWZwMS9a?=
 =?iso-2022-jp?B?eXFzSVdWL3p1RitJNEJVZ1FPSjdhNDBra1dGZWtWV2FWSXJWMTRobWF0?=
 =?iso-2022-jp?B?YWU3ZzdnTWYyaTNqVHc0aGZGSFBHZEg5VEN0SHJNSEVMb3RxYnVySnJj?=
 =?iso-2022-jp?B?M0s0WDYrbllHbVJvbWErZUMxL1hyTTZVb2crTVpTd1N2b3RyWlpuakhK?=
 =?iso-2022-jp?B?bzBJbGRhdk0zRSs0RkVXN1M0aytoTHZrVXpuenlwRGdBZWFQdjNWMjF4?=
 =?iso-2022-jp?B?RGh4ZkRjM3FQVm9aQnBlZ3BvSGV1NGdIMmk2V1IvVWViQ2psUXZJZ1ZC?=
 =?iso-2022-jp?B?MjYvdDhZNEhHdTZkU3QvNGcxczBPZVpOSWExQWJ6NnVLZm5DZU5GNnJW?=
 =?iso-2022-jp?B?ZG1ZL3I0QXA3QlVGaDBDaG8raC9sZ3owc3BrYkYvYU42dDNKN0FSSVNi?=
 =?iso-2022-jp?B?M1pMYVQyQ0UyOFE0WitvUlQ0VTBMd0dmaVIrK0cxMXVlU2huQzdRbjJq?=
 =?iso-2022-jp?B?WGx3S01qaTMvb2ZYdEtyK05ZL3VUYkhNd2FaUlRxc0xyajh0aTJvM0ll?=
 =?iso-2022-jp?B?ZHN2UFY1KzdSMW15WTNPN09FQTlzU2VqOVhGZlJxUjJ2azd4YkFHTUVZ?=
 =?iso-2022-jp?B?eGJzdXBiVzBoMzd2OVpaSGVZV080dHJJd0l3Qm82TEw0cEVSTU5CNGFm?=
 =?iso-2022-jp?B?MUNCQmUzYSsxNFhTQk9OSld5MW9uQ1JvQk9RTW9mcU9aUGJzNnNEWTFK?=
 =?iso-2022-jp?B?aFZjdDNjRmpSTTFDR2xQUXRjYjVDSUQvVVFiYXJldStaNnN5THRSYnFZ?=
 =?iso-2022-jp?B?eVdlcmFMTnVFUHh0cEVFeW5lUUxOVC95SzBZQXozbGtOekZveVcvLzk5?=
 =?iso-2022-jp?B?b3ZmWERTd1FwZVgrcjh0TmdVd0p4eFA4M3dLS08ydjF5ZmlXZnkxZ3Zn?=
 =?iso-2022-jp?B?Y1pnUVdUZjhhNE9Dc3I1ekc4a24xbDJEVlY0eHExQzBza3YrOVVmK1dW?=
 =?iso-2022-jp?B?bFd2Ty9KNkxYRHF4bmNOa2RCN0x5NHJFWDFWT1JBdGliWkdJdWZPN3Zk?=
 =?iso-2022-jp?B?d0g5T0RQN1pzaVNHZjd3bStHdUgzcHNFTlQ4Um5wSEV0V3V3V0lPb3Bl?=
 =?iso-2022-jp?B?cnFLNTJzWVdCdytUNTVLcEk3S0FrM3V1c1dsQXQrZ25pa0Vla0c4TjdP?=
 =?iso-2022-jp?B?TWJOTHJPSG9kb0crSFFueldGMVh0MHBWUWo0NDdENFFaN1VlRVJ0V2lN?=
 =?iso-2022-jp?B?WlI4VXVzeHFnejBZRk1LbnhUa3R1QVlVeTRUNUdxT3F4cm8renlnSXlJ?=
 =?iso-2022-jp?B?U00xWE1yNWtHTkZGdUYxeDJxbkMwcTdCK1hrTFpVc1NiZkRScFZEMHYz?=
 =?iso-2022-jp?B?ZjlVTDVkbmtrbW1oM3NoZXp6RkdZL0JodzZoaWFYVmlNMTR3UW9Pc0FE?=
 =?iso-2022-jp?B?OGhNeVNOaVZLWmhEVk9mSUJwaG5xL2ltQ2ROMUxobzBGNVJRUXprNm1X?=
 =?iso-2022-jp?B?S1AxYyt1dnJJNEZ5QytEcVR6REQ5bkVZc3UxZU4va0VsZmk3Wm8wQmZ0?=
 =?iso-2022-jp?B?WThyRFI0MTd4TWVQbExiaEJQQVByWVhxWmMyWktITXJqRCtuWm5mQk5X?=
 =?iso-2022-jp?B?eEtZeDBTd0lSRWJKR3ppemM2RFdidzBIUDY3a0pSQTYySmRkRWJva1p6?=
 =?iso-2022-jp?B?bEZuWFFYZnZWNHNqMzczUFFTSUxGV0hneTNwNWtkNENkdVd5Y0Nib0wv?=
 =?iso-2022-jp?B?ZGV3UkNtbjNtT2RoWlJ0WHl3YTR0bmxGUEJOczFTR3NnNHkvTllMcDBJ?=
 =?iso-2022-jp?B?ckNxaXRlMENRNG9mUjBicnk3ZjI4SEFCSmVPaHlkN3JjSjJubHFaSUxL?=
 =?iso-2022-jp?B?djZOemY0Smx3Q2k1ZjlOQnhtcmo4MUVzSWhxYzhKc0JrNm8zTEpLS21I?=
 =?iso-2022-jp?B?TTk=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dEdYZGs0d3Q4NlhmQVJzOWVnQjlhYjVVTDF4eVJ3MUt3dDJWWlREMENt?=
 =?iso-2022-jp?B?VzdDVTQ4Uzg2R3NQSEMwdzhFaDdlZzdCcjdsRDh1OU50WWp3cGRROXZu?=
 =?iso-2022-jp?B?aVd5TDdwbU5RRWhrSjRwMGZMNnM1bVQ1V0U2cy9KM2xGYXE5aHFpWDdK?=
 =?iso-2022-jp?B?d0FFYlFhN0lVT3ZWOFdaRXNHYzN1SWlCS1I4cTJmN0JrcXZPRG1xdk5T?=
 =?iso-2022-jp?B?SzFiNnN5MXd6bm9DQlp2NXpOb3l4bElPQTRTYjVZVWwvV1FFQ3RWTGsr?=
 =?iso-2022-jp?B?WVFoUUxLakdFamt3UWw3cmF4WE1IYldaSGRGck5VY2g3MjVqcXZCdGJu?=
 =?iso-2022-jp?B?KzBUd0NheEk4Rkg3cFphRWFCVmN4OUhnVi9UOS84RWNlQWd0UC80b1hp?=
 =?iso-2022-jp?B?aUlyVktPNDRPbkhiK0NTcElBdllPZGw0MVdteTJNbEUzVmw2OFZISUx1?=
 =?iso-2022-jp?B?czlkYzY2ZExtdi9xRVlUSTczOWRBZzF2OGk2MkxMcWVielMrOUZqaUNi?=
 =?iso-2022-jp?B?SStFL1lYNnlPUDRtTzlTUGNqQXRWL2lKN25hcXEvMTBhS3FYTGxUNm1I?=
 =?iso-2022-jp?B?QXhkb05WcVJwS3luN3g3SURzb2VVc1pDcmhVcjFrMmV2djdZcVZoSXBQ?=
 =?iso-2022-jp?B?RlFFVjR5N1g1MTVwSFZCM2p1NzZLNFV0OGd3VTNYYjZDOVhiVWtGdjVR?=
 =?iso-2022-jp?B?eEZGL1NKU25YWUZFVWNGRVRYZXREZ0xzQXRmYkZHMW1vTkNTdWR2OFhU?=
 =?iso-2022-jp?B?cDVjRklyeVRNSE42WjhWd2k1SjJLWG81YkpreW54VHMrdFM3dUZsd04x?=
 =?iso-2022-jp?B?aEtJL1Rhb2tEbGNvd1hHL1p4YmE1WWtDSHFBdzdrcm5TR2x2dXg0SCs5?=
 =?iso-2022-jp?B?TlErMCtJWjhqZGlyZHBtM0ZIK1o3MUtwRDhzdHllNmJzRVFOdVZGVmI5?=
 =?iso-2022-jp?B?Y0t0NGpiZk81ZG5scXVLbFg3dFFUMUFOejBXWVpTRkN2djYyUTg2dWRI?=
 =?iso-2022-jp?B?djlNOURjVHpKcHl3UUFOdmJHZk9UWk44eTlIZ0p3RDZLSFJ6YlRMZG1T?=
 =?iso-2022-jp?B?S1Y3ZDdiZS9lbzk0djJONzQ1RGNYZ0hBNVd4bTB1dTJRdVl4bXF2RVR4?=
 =?iso-2022-jp?B?eUNrN3BURHNSM0gyeEJkRk5DdEo3SjVyYkRZNVh6TWNmOGRwSyt5Ti9i?=
 =?iso-2022-jp?B?QnZOVnkxVnV2SXNrY3JnM2x4SndxVW15OS90WmM2MUVVczBlQXJTVDVm?=
 =?iso-2022-jp?B?SndOSU5pQ0RFZThJV2JVcTgrRFc2aFRwbGVUSGhlZkM2bEZycFo3SnF2?=
 =?iso-2022-jp?B?OHJxZXFBejdEL1B3K082blRCbDE2am5iNDlOdUpqRVh0TUd0NkNIN0wr?=
 =?iso-2022-jp?B?VWxxYVByQlRLNENXRTg2QkQ1L2xWWlV2YlJ0TVM0YWNPbnBROE5HeWIr?=
 =?iso-2022-jp?B?N2tvYzkyL3FNK3IrVis2NGoxTGg5anFUWjVjZGNXbTVPRDhwbWpleW51?=
 =?iso-2022-jp?B?U0VkZTN1ZEFMaHMyUHdiR2E3QnZLR1hPL1MvMDQ4cXg4WlprV2FldDZZ?=
 =?iso-2022-jp?B?M2xRaUNoYnZVM1E5bnI2ZTlKdm9YaXhKaEtYemdtZXJKSUs2cVc4dmpu?=
 =?iso-2022-jp?B?OG8zSXREeDhsbkhHK0Jrd0JDN2lhbFVVb25JbGVwdjNnd20rL1ZxUjJs?=
 =?iso-2022-jp?B?Unl1U0xoWWJmYlBFRGJwdzhsZ1ZnWFA3ZzJ3ZERRL0tzMUlEWU0rSmxr?=
 =?iso-2022-jp?B?eHgyVjErcXpCanJzL3YzeEhwMGlmQVRzaEZqSDlQMFQ1blBFZW05UWNN?=
 =?iso-2022-jp?B?MGxwc1ZMaUxtaVNxWC9ka0pvV1JicDBSWjA1ZmdpUkpIUHZxOGJ0S0ZX?=
 =?iso-2022-jp?B?Q2pmWjRKQmtZcjlqN2haTUR0ZGtYczZiQTFSeENsSDB5dm52azllK3l3?=
 =?iso-2022-jp?B?RHBhc0lVdDMrTnNMbytmckFSZFM2elBhUGFKdE1LR0ZwZzdkOVlQMTht?=
 =?iso-2022-jp?B?K0hCcndSU1plOXNweHpyWWpFVnREM2I4RUFoUWU4TksxYU9KcGxqRTVx?=
 =?iso-2022-jp?B?MmJhdjJuMXBtYkR0MDlyK3NyM0dieUNwMWFWTXlEbWlJODc2UnFBcWo4?=
 =?iso-2022-jp?B?VjdwdCtLcjVoV1AwQUoxeC9YS1hJTkpVZW92SGtJLytuODdkQVdjRjdn?=
 =?iso-2022-jp?B?Nm9PU2EzeSsvekVOUytrWkxaY3BYQTlvRitONUdkT0I3SXBYbG1NTzVu?=
 =?iso-2022-jp?B?VzJsVW5yRHRMSi9SZjZhMmhzWldHQUlkSEMvM2pwYlRQMHRlM09QenRo?=
 =?iso-2022-jp?B?Vmx2SGJ5enVaakJLV2Y1eWVkZU43dHpzYVE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838F9000A2E15ABD469B47AC2A42OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c601b42f-21a2-46ad-d882-08dd6acbe361
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 12:03:28.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6HPsFfONOEM+AiULizOaf9BXp9lEsRNRMxRc0jYeafb0+kDrX6mONQTD9OHlrfIWgcfzVzr2FuL8ABzGopteVu+AiRx/UB8fOr3aWdLG5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12751
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 12:03:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18345

--_000_OSCPR01MB14838F9000A2E15ABD469B47AC2A42OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

There is a possibility that this can be limitation in aide. From the test c=
ases perspective, aide is not detecting that the file has been modified aft=
er an aide check if the file is created under a sub-directory in /home. I a=
m looking if this bug has already been reported by someone.

As of now to handle this, we can either add home as a separate partition an=
d run the tests there or change the test execution directory to /var/home.


Thanks and regards,
Sai Ashrith
________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Monday, March 24, 2025 5:24 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; quir=
in.gylstorff@siemens.com <quirin.gylstorff@siemens.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partit=
ion for qemu security targets

On 24.03.25 12:35, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>
> Across all QEMU targets, the mentioned test cases are failing ->
> TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1
>
> All three of them are related to aide where we explicitly modify a file
> and check if aide is able to detect that. If I run these test cases in /
> var/home/.. Aide is able to detect that the file has been modified
> reporting an integrity failure to journal logs. But if I do this in /
> home as working directory to run these tests, the changes are not detecte=
d.
>
> We can also change the working directory to /var/home here, instead of
> deploying separate home partition here -> https://gitlab.com/cip-
> project/cip-core/isar-cip-core/-/blob/master/tests/templates/
> IEC_template.yml?ref_type=3Dheads#L74 <https://gitlab.com/cip-project/cip=
-
> core/isar-cip-core/-/blob/master/tests/templates/IEC_template.yml?
> ref_type=3Dheads#L74>
>

The idea of linking /home to /var/home is that it is (widely)
transparent to its users. What is aide exactly doing to let that fail?
Does it reject to follow symbolic links? Why?

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OSCPR01MB14838F9000A2E15ABD469B47AC2A42OSCPR01MB14838jp_
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
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
There is a possibility that this can be limitation in aide. From the test c=
ases perspective, aide is not detecting that the file has been modified aft=
er an aide check if the file is created under a sub-directory in /home. I a=
m looking if this bug has already
 been reported by someone.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
As of now to handle this, we can either add home as a separate partition an=
d run the tests there or change the test execution directory to /var/home.<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jan Kiszka &lt;jan.ki=
szka@siemens.com&gt;<br>
<b>Sent:</b> Monday, March 24, 2025 5:24 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;; quirin.gylstorff@siemens.com &lt;quirin.gylstorff@siemens.co=
m&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M=
#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.c=
o.jp&gt;<br>
<b>Subject:</b> Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home=
 partition for qemu security targets</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 24.03.25 12:35, Sai.Sathujoda@toshiba-tsip.com =
wrote:<br>
&gt; Hi Jan,<br>
&gt; <br>
&gt; Across all QEMU targets, the mentioned test cases are failing -&gt;<br=
>
&gt; TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1<br>
&gt; <br>
&gt; All three of them are related to aide where we explicitly modify a fil=
e<br>
&gt; and check if aide is able to detect that. If I run these test cases in=
 /<br>
&gt; var/home/.. Aide is able to detect that the file has been modified<br>
&gt; reporting an integrity failure to journal logs. But if I do this in /<=
br>
&gt; home as working directory to run these tests, the changes are not dete=
cted.<br>
&gt; <br>
&gt; We can also change the working directory to /var/home here, instead of=
<br>
&gt; deploying separate home partition here -&gt; <a href=3D"https://gitlab=
.com/cip-">https://gitlab.com/cip-</a><br>
&gt; project/cip-core/isar-cip-core/-/blob/master/tests/templates/<br>
&gt; IEC_template.yml?ref_type=3Dheads#L74 &lt;<a href=3D""></a>https://git=
lab.com/cip-project/cip-<br>
&gt; core/isar-cip-core/-/blob/master/tests/templates/IEC_template.yml?<br>
&gt; ref_type=3Dheads#L74&gt;<br>
&gt; <br>
<br>
The idea of linking /home to /var/home is that it is (widely)<br>
transparent to its users. What is aide exactly doing to let that fail?<br>
Does it reject to follow symbolic links? Why?<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB14838F9000A2E15ABD469B47AC2A42OSCPR01MB14838jp_--


