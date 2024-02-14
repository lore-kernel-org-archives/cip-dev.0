Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C010EC48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:27:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.43625.1707924463114589964
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 41EFRemH3454930; Thu, 15 Feb 2024 00:27:40 +0900
X-Iguazu-Qid: 2yAayDBj4OPbpyP4VM
X-Iguazu-QSIG: v=2; s=0; t=1707924460; q=2yAayDBj4OPbpyP4VM; m=NosfmxRaZxZJuDmqnoLQHPCRnv+VRPjdWU00DQx7Iqc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 41EFRdP42707484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:27:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3q+xSHSz3yeKoxpYFveQ72jhkiknwsvPWTIaZhNH1SEXOB+WDwOMMro/FQdKOMWOhw+fMoWIf45tzej1it5CvYbA6bOrNXSHKneGGnjuWR8c48KWDi9btrVkkHly7ncxQEs0nxr/oUm27RMuxd6H+MBx0lJDOHw/137EZ6Az46DK14bqb2qt3RbBKpSVSaOiQSY3is3DhzW+JyWiZbbCdpkk+9TC9bs2pOzc8CJNYj5IpaTjUArlcGuqlX4bmj4VsOOuCjU86iTBhU289T12T9FSFLyUSegY/I8+CJ6ZbxJDBUlQ0N3akKd3t5u692e8xyj1AoLPniZFPCuq9p8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5OP1/uQMIoy7bjbvgd/9GdRLomlb70GsBK9lzG4CVg=;
 b=ES3A4MNirBn0TTgUjo/R0cWMPUfI4SL/PnUcBjkwsGKa7y8Qjq5Je9dpFO75HuvHWxt3BMEhkZeIsnFWzu3X98/UdCWjdaueo3sNdi5fCD8NNqxdXCaKN5QpmomFCnUmfn2nD9AkzGtM6C9PyR0/reyCPz9v9/AHqh9mWMh/8Rx1vDypEoe0hMrMCZGuWwC8Sw3td+04EcVci260QRNpJlVqbAyag1m3+JXJkx0H1KWltWbVgEKt4kT3pBTCu1Xq9rcVLPd10byDAvyd8BM3nnA0i1igf2sUtnBBRiZ32gIV6azNqI2h98SvEmMHnDByzHBlxMO026b00h/mPM+HqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core 1/2] deploy-cip-core.sh: Upload only
 .swu file for v2 QEMU security targets
Thread-Topic: [cip-dev] [isar-cip-core 1/2] deploy-cip-core.sh: Upload only
 .swu file for v2 QEMU security targets
Thread-Index: AQHaX0FHDg/NTc5B7k+r1EOlt2KhYLEJxiIAgAAvG/A=
Date: Wed, 14 Feb 2024 15:27:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61030B0D45441714BE2C1B79C24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214122809.3541505-2-Sai.Sathujoda@toshiba-tsip.com>
 <43b79499-8726-48bf-8c66-27768f63cc69@siemens.com>
In-Reply-To: <43b79499-8726-48bf-8c66-27768f63cc69@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY3PR01MB10986:EE_
x-ms-office365-filtering-correlation-id: f6d41a6c-dd09-45f0-6133-08dc2d717958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pPYbZOojuvociHXBpzBUOSK1klx+QMfHWqJ49wATHBpX8Muj/abY1qTLB3xV/IwS2rChbW63FQPGYIdIZLJ9oQqI8QtTgWhEu+HBpuLvLbCA+Qwv73LMD+fYg6yYmVMmWCb4zIqYvi5UK9bWP8LIICWpfcLaljqJpqMvdH6OyqMoj8L4DgfqTMghxtxyPiRfDqE8kisFVl4b01PnoGHShY4RRVXSOMHoM0Jy09/tfaz0yjyw5Pi4miJHagDdFNIQfnsvWhqmTP6ypDf8eGBsjT6mgsv8nyGeQux9J5GPDn7/AZs+WBgBSFgY6gTDgFYb46Mr9yQv+EmV24PlSXVO/qdLIdafmIqmUQUqtLROMcuUXk+ie2W/LCLly4Jj9yx/oSyH5dQKYdYjZYAab4R9p83ZBOnn5mcS0XDWOFihfQ9BzwsnLbxERDiLWzHK+lW15jyeK7HVWHS9htsX9fHnOZ2JWbOFavsanzxuN51p2ze6dHwKOf/P9D9DChlS5YtNGVMHHbf7t6ctA+Laz2YjlTqdg8vqf/AZH/mJ63gvR2cTVQqVaqv6K4BcKIn9ljBF5JZoEq2VmK0yuoQCDouBVbNjeDL+0tlTyiwgsZPviUkGlqYvH5fNX3QlVwUezD0A
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(6916009)(8676002)(66476007)(5660300002)(8936002)(64756008)(66446008)(76116006)(66946007)(66556008)(52536014)(2906002)(15650500001)(83380400001)(38070700009)(26005)(33656002)(122000001)(85182001)(86362001)(71200400001)(38100700002)(6506007)(316002)(54906003)(41300700001)(53546011)(9686003)(478600001)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NzgzNzBYQWxIb2UyWlM2eE44K285N2J3MWMwckdvK3NSVUYwenIwY0hWcU5U?=
 =?utf-8?B?Q2ZTTVpRWFZwU1k4dE80dEdHQ1RJSUdwckc0d0VKejFjY0I2ZXRVWEM4OW1W?=
 =?utf-8?B?ZUZlNVoyck1wVVdHM2lqWTMyUGpDdVdsT1ZrN2NZbzRYY1BHZjFyb3g5Qndw?=
 =?utf-8?B?NFhkdlg2c0MvYWFiWlAyeTYwV1E4M3lSSWtIWXRjTlhhbTN0S0JiMFBqaDgw?=
 =?utf-8?B?WTFYdlV2RERwZE1QN2cweGRXdDNiQThVZEk3Vm1zbEkyVWdqVWNXUlZOZEdp?=
 =?utf-8?B?Sjg3ODQ2djlsYXJ3QkJqOHRtZzMzZU9iazRoWE1rQUh3bXMwU1NnK1lRdEl4?=
 =?utf-8?B?TlEvakQ4VENHQkQ3RExmOWVvUmtsWDJ4TkRadFlJMXFHZTdTcjNHaUNPZFVm?=
 =?utf-8?B?V0s1OXpLMTJBd3RRTHBnYkZhaWk1QnJCcHZMNEx0Tk1ubWdzUUNUYzlGWkJv?=
 =?utf-8?B?L2lxS2hlRWQ0WURqTWlPM2dGaWU3MWZvL3BUZHBtZFNLeTZxMEFlelVrSjM1?=
 =?utf-8?B?YmI1ZUlkRXNYSU1seFA5MFNoeTBXYmVYSmdMdE5iUmcyVEh2R0wvbnU2Y2R6?=
 =?utf-8?B?eFd2aVBGU0xtYjIxMzhLaVhnUHhtekRBaVJHVVM0ZUVmaHhiaDFBQ3k1UjBx?=
 =?utf-8?B?Z3lkc09oT2NLdkVFQ21YMC9vVkI4QWRzcHJibjNXc2p1RmNjN3p6MVRIMVho?=
 =?utf-8?B?NDVKeGR4Q2V0UzB2OFl3REM0OHBtbWxZdTE5eGlwcXpOOHNLdFhZOVNGUSt4?=
 =?utf-8?B?SHh6WEdZNzNRbnAvRWovSUprbFo2d0dvYUpRUnplZlpiV0RCYThOZW1OeXRn?=
 =?utf-8?B?bEVwczFYa2FDbkV2MFJBM2gyN0NQclBjT3o0MWc4S21zaTdCSDJvSTJibmhh?=
 =?utf-8?B?Z3pSNCtaeTErUzR6MUxwUitNaFJtU093RzBKWkJmaC9vQi9ZMHhlcFdKMFll?=
 =?utf-8?B?ZHI4MU1JSG04L0pWdEpRdnJ6ekZMZ0Z3bkk0V0xqclV1RnNNVVRmalhoZW5Y?=
 =?utf-8?B?NDRPNWI5eWRrTGxlQW5OUmZxamY4VzMycWcvenVUYjZodFFUMloyVGZJVndS?=
 =?utf-8?B?eEpDUWtXYU4xclJCekk3UFhVMExNbmM2QXNSalR5UFNWQjlYcUY5UmFicWpL?=
 =?utf-8?B?V1FaczRtejZja3g4SUxBK3kwcDhSMEFFNXF1OUp6aTFUMms5Y0ZWRUM1d2tE?=
 =?utf-8?B?WTYrWVdML1FJRmowcThqQU4wWnUyWFVzbTh4eEg4d0lSZ3FOQnRsSjNkZktv?=
 =?utf-8?B?OUcybVMyREV1STBUTEhFdExqZjNuYzJhRnRCTVJWM0hnekZDa0pCZTFFTG9Z?=
 =?utf-8?B?Qk94bVV5c1NycmpBT3kyajZBcUtNdFFlcWpMRlVnN3hEUWkrZkdyRW5NYlE2?=
 =?utf-8?B?cmx6T3RwS1FaZGg0WUNad1ZlekZFS0IyQktXV2ZLZnN0ZG9sOHBtdnJuWGNF?=
 =?utf-8?B?TE10dTVDUXhHNE1Sd3dRK3JOVHdzRnQyN3dIV0lsQmdiaUhIMWIxbEdCVCtV?=
 =?utf-8?B?ckJ0dHRkOEhCWXpOOFAzR2hjeXE1Mkg3d21ZbTM0NFlQaEpEM3pCek4xcmdR?=
 =?utf-8?B?R1FaNHlZQXRtcmtWa0JiUzZLM1V1ck11VitrRnN1emc1blhtK0VCVVJNUGtD?=
 =?utf-8?B?bTBER2ZOck4zbjAxekt3R2Z5OEZsUStOVGJEbzFGTmlVMWJNb0dFOUtCNlF1?=
 =?utf-8?B?RFA0aVhvUXZYMjgxRno4b1BhR0l2d0dqMDFlNW1LSUJ0Mk5qcHdxMjlYbGpV?=
 =?utf-8?B?WlFkeStaRHRKa3E3aUcrQUdOenBHSmhoQW1Ybzc3TXp4L01XalQrN2VEVEVV?=
 =?utf-8?B?R2E5c1RQRjFZSEpqcmZHOWNFRi80aGRLRnpWNXZQQVBTejBGS2xLT21CZk5j?=
 =?utf-8?B?WCt6MGZWUHpyMm9GWVM4Vi9VV1VOSkJKd1pOeDQrR0RBRjV4d0k0blZ1bjh0?=
 =?utf-8?B?YVNZQVFZQXJ0VjBpMFZkdXcxSlREZjRaMWlqL3Erd0cxT0JyWDZjMHJhWGVQ?=
 =?utf-8?B?YXRUam01b2xDbGJIV1NHZDdrbU9qSTNqS2Exb25QVUhwYUVBQTJFSGM0a1Js?=
 =?utf-8?B?OVVENnVtVURKcmdtMWo2bHRaREJRL0dKTlV5d3M5T29CUFNyYUdFMkp1MkJw?=
 =?utf-8?B?SmQ4NkhzSllKZndaZ242SnFrZmZkNWtNUTl1dkFxT0FZTnJlZHV2OXYvU2xX?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d41a6c-dd09-45f0-6133-08dc2d717958
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 15:27:36.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cr7fRH2Ap6xwawspjej7eaTR/QCt+cnPiclriqwuYo8pE/6EAkuBW7yOsFPoQ+3DogP4FlY2OT4Xdq8G2RHAkUH2YAj0+cfL38NO8i7RyBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:27:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14973

SGkgSmFuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIEN1cnJlbnRseSB3ZSBhcmUgdXNp
bmcgd2ljIG9mIHYxIGFuZCAuc3d1IG9mIHYyLiBXZSBhcmUgbWFpbnRhaW5pbmcgdXNpbmcgdXNl
X3N3dSB2YXJpYWJsZS4gV2hlbiBpdCBjb21lcyB0byB2ZXJzaW9uIHJvbGxiYWNrIHNjZW5hcmlv
cywgd2UgYXJlIGRvaW5nIGl0IGRpcmVjdGx5IGluIHRoZSB0ZXN0IGpvYiBpbnN0ZWFkIG9mIGRl
cGVuZGluZyBvbiBhIC5zd3UgZmlsZSB3aGljaCBzaGFsbCBpbnRyb2R1Y2UgYSBzZXJ2aWNlIGZp
bGUgY2F1c2luZyBrZXJuZWwgcGFuaWMgZHVyaW5nIHJlYm9vdC4NCg0KVGhhbmtzIGFuZCBSZWdh
cmRzLA0KU2FpIEFzaHJpdGgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zz4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU2Vu
dDogV2VkbmVzZGF5LCBGZWJydWFyeSAxNCwgMjAyNCA2OjA2IFBNDQpUbzogYXNocml0aCBzYWko
77y077yz77yp77ywKSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVD
IE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGth
enVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8
re+8sO+8lCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+OyBRdWlyaW4gR3lsc3Rv
cmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KU3ViamVjdDogUmU6IFtjaXAtZGV2
XSBbaXNhci1jaXAtY29yZSAxLzJdIGRlcGxveS1jaXAtY29yZS5zaDogVXBsb2FkIG9ubHkgLnN3
dSBmaWxlIGZvciB2MiBRRU1VIHNlY3VyaXR5IHRhcmdldHMNCg0KT24gMTQuMDIuMjQgMTM6Mjgs
IFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gRnJvbTogU2FpIFNhdGh1
am9kYSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiANCj4gQ3VycmVudGx5IHNv
ZnR3YXJlIHVwZGF0ZSB0ZXN0aW5nIGlzIGVuYWJsZWQgZm9yIFFFTVUgc2VjdXJpdHkgDQo+IHRh
cmdldHMsIHNvIGlmICJVU0VfU1dVIiBzd2l0Y2ggaXMgZW5hYmxlZCB0aGVuIG9ubHkgdGhlIC5z
d3UgZmlsZSBpcyANCj4gdXBsb2FkZWQgaWdub3JpbmcgdGhlIHYyIC53aWMgaW1hZ2UuIFUtYm9v
dCBiaW5hcmllcyBmb3IgcWVtdS1hcm02NCANCj4gYW5kIHFlbXUtYXJtIHRhcmdldHMgYXJlIGFs
c28gdXBsb2FkZWQgZm9yIHVzYWdlIGluIExBVkEgam9iIGRlZmluaXRpb25zLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogU2FpIFNhdGh1am9kYSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29t
Pg0KPiAtLS0NCj4gIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoIHwgMTIgKysrKysrKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoIGIvc2NyaXB0cy9kZXBs
b3ktY2lwLWNvcmUuc2ggDQo+IGluZGV4IDdmNmNiZTkuLjE3ZDRlZDAgMTAwNzU1DQo+IC0tLSBh
L3NjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoDQo+ICsrKyBiL3NjcmlwdHMvZGVwbG95LWNpcC1j
b3JlLnNoDQo+IEBAIC0xNSw2ICsxNSw3IEBAIFRBUkdFVD0kMg0KPiAgRVhURU5TSU9OPSQzDQo+
ICBEVEI9JDQNCj4gIFJFRj0kNQ0KPiArVVNFX1NXVT0kNg0KPiAgDQo+ICBCQVNFX0ZJTEVOQU1F
PWNpcC1jb3JlLWltYWdlLWNpcC1jb3JlLSRSRUxFQVNFLSRUQVJHRVQNCj4gIGlmIFsgIiR7RVhU
RU5TSU9OfSIgIT0gIm5vbmUiIF07IHRoZW4gQEAgLTMzLDcgKzM0LDE2IEBAIGlmIFsgLWYgDQo+
ICIke0JBU0VfUEFUSH0ud2ljIiBdOyB0aGVuDQo+ICAJeHogLTkgLWsgLVQwICIke0JBU0VfUEFU
SH0ud2ljIg0KPiAgDQo+ICAJZWNobyAiVXBsb2FkaW5nIGFydGlmYWN0cy4uLiINCj4gLQlhd3Mg
czMgY3AgLS1uby1wcm9ncmVzcyAtLWFjbCBwdWJsaWMtcmVhZCAiJHtCQVNFX1BBVEh9LndpYy54
eiIgIiR7UzNfVEFSR0VUfSINCj4gKwkjIENvbmRpdGlvbiBjaGVjayB0byBhdm9pZCBkZXBsb3lp
bmcgdjIgYmFzZSBpbWFnZSBhbmQgcHJlZmVyIG9ubHkgaXQncyAuc3d1IGFydGlmYWN0DQo+ICsJ
aWYgWyAiJFVTRV9TV1UiID0gImVuYWJsZSIgXTsgdGhlbg0KPiArCQlhd3MgczMgY3AgLS1uby1w
cm9ncmVzcyAtLWFjbCBwdWJsaWMtcmVhZCAiJHtCQVNFX1BBVEh9LnN3dSIgIiR7UzNfVEFSR0VU
fSINCj4gKwllbHNlDQo+ICsJCWF3cyBzMyBjcCAtLW5vLXByb2dyZXNzIC0tYWNsIHB1YmxpYy1y
ZWFkICIke0JBU0VfUEFUSH0ud2ljLnh6IiAiJHtTM19UQVJHRVR9Ig0KPiArCWZpDQoNClNvLCB0
aGVyZSBpcyBubyBjYXNlIHdoZXJlIHdlIHdhbnQgYm90aCBiYXNlIGltYWdlIGFuZCBTV1U/IFdo
YXQgYWJvdXQgdGVzdGluZyB2ZXJzaW9uIHJvbGxiYWNrcyAob3IgdGhlaXIgcHJldmVudGlvbik/
DQoNCj4gKwkjIFVwbG9hZCBmaXJtd2FyZSBmb3IgYXJtNjQgJiBhcm1oZiBzZWN1cml0eSB0YXJn
ZXRzIHJlcXVpcmVkIHRvIA0KPiArYm9vdCBzZWN1cml0eSBpbWFnZSBpbiBMQVZBIGVudmlyb25t
ZW50DQoNCnJpc2N2NjQgc2hvdWxkIGJlIGFkZGVkIHRvIHRoaXMgYWxyZWFkeSwgZXZlbiBpZiB0
aGUgYnVpbGQgaXMgY3VycmVudGx5IGJyb2tlbiBhZ2Fpbi4gRmVhdHVyZS13aXNlLCBpdCBpcyBv
biBleWUtbGV2ZWwgd2l0aCB0aGUgb3RoZXIgYXJjaHMuDQoNCj4gKwlpZiBbICIkRVhURU5TSU9O
IiA9ICJzZWN1cml0eSIgXSAmJiB7IFsgIiRUQVJHRVQiID0gInFlbXUtYXJtNjQiIF0gDQo+ICt8
fCBbICIkVEFSR0VUIiA9ICJxZW11LWFybSIgXTsgfSB0aGVuDQoNCkhvdyBhYm91dCB1cGxvYWRp
bmcgZmlybXdhcmUuYmluIGlmIGl0IGV4aXN0cz8gVGhlbiB3ZSB3b3VsZCBub3QgZXZlbiBoYXZl
IHRvIG1haW50YWluIHRoaXMgbG9uZyBsaXN0ICgrcmlzY3YpLg0KDQo+ICsJCWF3cyBzMyBjcCAt
LW5vLXByb2dyZXNzIC0tYWNsIHB1YmxpYy1yZWFkICJidWlsZC90bXAvZGVwbG95L2ltYWdlcy8k
VEFSR0VUL2Zpcm13YXJlLmJpbiIgIiR7UzNfVEFSR0VUfSINCj4gKwlmaQ0KPiAgZWxzZQ0KPiAg
CWlmIFsgLWYgIiR7QkFTRV9QQVRIfS50YXIuZ3oiIF07IHRoZW4NCj4gIAkJZWNobyAiVXBsb2Fk
aW5nIGFydGlmYWN0cy4uLiINCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpM
aW51eCBFeHBlcnQgQ2VudGVyDQoNCg==


