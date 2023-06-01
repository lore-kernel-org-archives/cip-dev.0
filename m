Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9990C7EE23
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 11:40:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.28966.1685619629186639187
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 04:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 351BeP4V024152; Thu, 1 Jun 2023 20:40:26 +0900
X-Iguazu-Qid: 2wHH8MjPb8KIn2BDdo
X-Iguazu-QSIG: v=2; s=0; t=1685619625; q=2wHH8MjPb8KIn2BDdo; m=Esmo0ed1xPPMceshie44mzgaNUz4DJrksDpZDBhPAKk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1111) id 351BeNp3010243
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 20:40:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggfB1f9A1qTOkAvtbdqUjffm1b8Dfyueou2wED1gLVsB/mJbC7Jz+wDelYXo9WJo/6dUBYkGJQPSUgXFW+s7bLeKtW1UExxVUVo8gzYHb4I3XJrq+oRemfSFw9POK9HwQZslvo8gm2yXM980dX5YeXxzng/M517jJKws2rbjB4Hjp4PhN4x+NiLmM9v0JyhMFfoJluWLYR47c+HMlDQ2CpIhjqBtdpdnSk+NegUEA2hxIa8/wmEnUa69yStzoI8pFaVtocokMuLU/L8BCU+hJu1jqkDtUA/7V9MPT4tn6eApB63v3CxLoyd0MwbvLh/JqEKW7Oq9I/pNQ/H/UJrO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDoKzQJiekcHN26R3ZuTrtR32Ou/Jn07gIjB/vUxAcw=;
 b=NRfm+ByXtvUEbYxv9Wfim0npCY51F8Is2E2ZWkNfLI0itqRmKLQDfG5N0pir9JfdB4lOn9PSHKoOTIUh15oaxzwp5VUKrG2pbXkWdm87W0ELg90imRT20SrMNA+VFS92uCxuuNVdUOfwqs9XrBZ8DC7x0+FpItezAn6ORKKesSxUGSmMjWM1uhYlVbu9RD45CRiErEV1ZD9fKqEG/mqqGOmQspxZjWxYhDLru+SGFk+SeYR1EZxjHSb+AIRK4jd82pmi87aLebHcpP2meATcHRnvImHNldwFJxgHLHf5rCDvE2X93hQbt34NuLbLnqueuiONV49YhEvh41ihs2TtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproducible
 checks
Thread-Topic: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproducible
 checks
Thread-Index: AQHZlHS1C93NBKHP50+pnouU5JtlFK91wJ3QgAAGhwCAAAZ64A==
Date: Thu, 1 Jun 2023 11:40:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55424890C0F15423A924F380A4499@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
 <54ccb6ba-4a00-38b2-bc65-65a7baf86957@siemens.com>
 <OSYPR01MB5542A26EB39703EE7F2421E1A4499@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <2b4b63e7-1e6e-beba-3dd3-bfaaff1f801e@siemens.com>
In-Reply-To: <2b4b63e7-1e6e-beba-3dd3-bfaaff1f801e@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TY1PR01MB10754:EE_
x-ms-office365-filtering-correlation-id: ac65790f-5b27-45e4-40b3-08db6294fb43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 x12p6WfU2Vkd3rhxJcru68JTFCfsqcrID82K9zFRJJhxViBJOigIXUQZDIneW/yIe1QZ7FlzSyAI8oycgjTFmAJjXS3LoTZMiP5C7heWYwE/y10P/x2GH48b3OVBPQ70jhE2EHKGSHhTZaij2hSfMpJfCLVO7rnIEvdNRc7Vx6euVLOPLdbr72WsdQCjFvnLaL4Z5OixznrLAD4jR4T/XLCUG2mWpwXlEH9zrHleerCA+PjE0xYhKMORobfG1g+2cIQlSPw0yTnXGPxhCcfJE6Ee6YaX9H2D19mb0u1VXQxJO7ILhWaJb+pAK4L70HEFzhhI8aAr8jRqIvIp3E2pwNg9A28hyoQXl/aKloWjgzlm77s2Aue6JxzkVXvrIkTHNoUXXLkIZmZJPDb+i/BN3pLu2QKcWR9Rm3u/B4QCK9MOhYoX7nSG74fiFT8vCyWKQqBoL1c5IALfVVPu6L62LF5ZCOBmEBlatrgiczbSiPlKn8lXtQho7LRKt3y8uPR8DytAkDlybMkju1w5CfqwTWP8lAAr0whYrEN3OMRmS6qOGwHehoQckijEONhULICXpK9IdoBD/orJaa4XmaNClNBDfHlatwwIlKpXBcANrjioUEWSeKXWQWxD3xznvaKU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(5660300002)(8676002)(52536014)(66446008)(4326008)(8936002)(122000001)(66556008)(66946007)(76116006)(64756008)(66476007)(41300700001)(38100700002)(316002)(38070700005)(2906002)(55016003)(86362001)(107886003)(186003)(33656002)(53546011)(26005)(9686003)(71200400001)(6506007)(7696005)(83380400001)(85182001)(478600001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K3pGY0RBUHFoU1U0WnhhUWREOGJWNTA5SnN4eTJLa21LdzFUVEtLTkx4QUU0?=
 =?utf-8?B?amhEdklTczlXc3pYcllNbG5mSEc3L0hRTTgrQkQ4cmlSU0FvdmRTVGFZN3lq?=
 =?utf-8?B?SzRQRFBxVEV3enVLWHVGd1kwYW5rbzVBTmJUV3VhYzdBd0lRU243L2g4eVN6?=
 =?utf-8?B?eitrS1FHdDl3Vm5JUWk3eEl5Z0xkNDFMaWltS0Vycm5UbENxNFV3Wm5XR2pz?=
 =?utf-8?B?bDJlYVk3WlNQa2FFdXkvYzB0WjRDTGFtd3NQajh6UUV4THUzMWhQQ0RYeHRi?=
 =?utf-8?B?bDR3VG1NcHlSQ2U4c3ppKzN5TEVIQjZKMDN5c3pKY1pleStYS3NTc25WcFNV?=
 =?utf-8?B?WTZQQ2w4OWtaZ2R1eUVORzV2bzhyTDAvWThlZkJZOGZzYnRKTnBmMXZWSFVU?=
 =?utf-8?B?a3FXcVlUYnFKTHBKYU9xdWtvOUxCQkszVHpCSysxWnpjYVhXSHhxRXhhMjl6?=
 =?utf-8?B?TStrNWFDa3JoVzJ6K1c4L3BYNDRUUGt4VnNPekxPbEVMN0R0c0tKTklkSUFa?=
 =?utf-8?B?K054ck9TYzlObTFkdkI2eTE3dDF6QWd3a1J2MEh0R2t0aS9VVUVCaTA1VWpI?=
 =?utf-8?B?TDNMWW8xQlJoMnZGbDlCSWVtc3hlY2YxejBOQVhJd09Tc1hZS2hxQklsK1Fk?=
 =?utf-8?B?ZWxFZ2lBYWxHNytzWDhrUXlFWUw3cTFNVzRpeE9jSUZ5d2JRVDB0dTZLZWpB?=
 =?utf-8?B?ZnYrTlhuY3d3R1UrSkh3Rm5ud0Q4SHRKWFZNK3VDUjIyakdDcndwV3lLOVND?=
 =?utf-8?B?Z0tOZ0VhY0pNWXdlMUJVRUcwWXdTZ1VFSjNTTlJpalVWbUhVQ3RkZ3dVaHFJ?=
 =?utf-8?B?bG9aQXpSSTdtU1hnTDFYQmVMVGtnS0UyVGYrUnVTd3hxRWdmVnFwTTVkb0xX?=
 =?utf-8?B?YnB1UkNCT2x5SW93a25XQUhySlRMaktaemZhL3o1c2pMSzVOL1dkR1o4NHVI?=
 =?utf-8?B?azlINTgxWnJKeUpWeVRPUk5KUGdVVk1OM2FUMHNNSVZLaXAwSUVvMloyc3lo?=
 =?utf-8?B?VVp4Mk5ESzQyakZ2VktBUGlmU3ExMHRyR24yNmxoRUtXbjg1VEwrV2NSTWdR?=
 =?utf-8?B?eGZWY3hNTnNJNWZSRWlCSkZrb0dxc1hJclpRcHhUYXdJQ2U3cDhUYS94aTRI?=
 =?utf-8?B?b0V6ODZuSGxEQUFRVzAvczA4NWNkWXZtMkFoSHA3bTNXMGZobjZzSCtmRzVo?=
 =?utf-8?B?bTlCd1Vhc0VSTlZkL0FNMW9ZUy9kSUp0clVORktXZ3NmVWRESGt1WlcxKy9a?=
 =?utf-8?B?dnRNQWZJQm4zQWdld1MySWJvbzhHbSt3MmU4STgxRDFXY0pNL1JuYVRibTl1?=
 =?utf-8?B?MWE5SnRPOTJQZGluRTZTc1ZRYk03MWoxR3diMllneUI5czNKWU5Da3NQczFZ?=
 =?utf-8?B?UDc1c016U29TWkV5dDh1UlhhMm1FaGZJdE9sSDc0a2NwVFJnUFBINVd6djY3?=
 =?utf-8?B?UFdCdnhZSE1aYnBpQ0g0QWlKZy9Oekh2Zm5LbDZNM3VFUmZ2aGRHbW1JQmQ5?=
 =?utf-8?B?emlUV0tZRUVtMzgzYS9zL2o4TUtKVXFZVEFWQzRyWG5MUkhMZDJqWUJLWE5w?=
 =?utf-8?B?cTdKV1kyY3J5SDNXb0NQckVqVkUrdFloaXFINGZHNjExZmZwc0I4RXBHR1Rq?=
 =?utf-8?B?U0lpL2ZGWkhIdUlRTTJrcTNmR1doZStxTEdoZFp5ZVZlY05iSmlWMnd0ZlRW?=
 =?utf-8?B?dDMxVmtuMXd6dk9vY3lENVp5aWxKbDBvSXp0ajNHWTJWeTJVbURmRUtLUTBW?=
 =?utf-8?B?R2J5bFhWcm5aYTU1R1diNXRSaWEyeDlVZ0kvU0JSbnpBZnV5WTl4TTc1T3J4?=
 =?utf-8?B?N1o3YVcremJPV0NJbGNXeW51aUhHVm1VVUhhK1A0Y1JrUlRzY3lPZHVOVVc2?=
 =?utf-8?B?QW5DMW4wUGlLby90UVQydkRhWjgwMTBiUDVaVEcyb2xYMVRiSmxJNzVGdEhT?=
 =?utf-8?B?SFUyd3UxTm4xbTJIZFIwNllqY29ZTGNWYUp0OTlFRHVPalgrd3JzbzBxNEhY?=
 =?utf-8?B?ZksrMDl3SlhPNGRSMFVjTmZpQ2hjd2ZrNDhPYW9xUElTQ2xCdFZQcG02WFF3?=
 =?utf-8?B?NTMzZkxHZHVnZlp1NTlPdklyVll4eGFVUlFIV0tTcTFlQlpjaXBEUUpRTjhz?=
 =?utf-8?B?UGFvVXBGRzZlcEFmelNXbUdOV3Bqd0lRSnJMM0VSZkp6L0wvUDdIRm4xZ2Z2?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WSd9nB32qAVl6ZPx+o+0xV6vrUpTOmDTRUZw+xW9F0EmOxuw3+bN+fpr4WxASv/9eKnyoB4NckoKeKPr823/dYkKGpEd8mnJThrnFBpkIuM6I36H6pfi1MyEM7pb0ij/lFq1HrHqMPySwVwxuuu+lwWFlH2ASu7/6fMQD83easCO9jMWR3MtR8I+OmrYaw9fv15DXqC3k+npTBPTkUMKydgQn5J42JnQyJAREltrMvG+bDmnqRO99aM9NQxmY4P0LR44dFoM0P0RtUum9t5393Zl5bfUZ7xFF2BLtsKTstk6iwGrF8vXtVB68RmVhgD1JCI7niL7yVsTwWpJr2R/KuWjPISAUnQLt37VcByG2Oefx9m6xlL8ESIkPNMWdVCmt9N7jo35klJpMP3yWTnLijaveFhtNRG3SZ0e6medH72rb/S5S6nJ0hBcTvjPSF8T13Fiaw6oVRCFuUy/nkOAUAgts9DBxuCipbL3hE8poyouG7QRUjN5pI4CyQaop0qpoQZzTytCng8RpsXLb1IdBtV+EOY2HGCPzhv0FxvO1/8pOTirOMbCAps8mmq2NE/BGZNfUPaGz51PAf8Of3kzf+gbAwTZuNH5xtYMcwCattessQaIixXQUeo5cpYs5mZ2bmTQZzq4ZnplKDWK/mMXbLE6w7mGOzA4KwwsAsmu7rL8Kdjy5xrUdcNL9OHBrRzMCvazIOcpMT2EOz2CsC8Sr9Aoz0ceOX9MTQKBlOHyMAjcPUUtbewDhH1v2nf01atjbFYm2CmXLS8q9mndjR0hd8ALs4QKiYTezEh8xflJRG21LqphWkZTdJI96hnGSb5qZaElAQXI+/pbEPmjOz6hZg==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac65790f-5b27-45e4-40b3-08db6294fb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 11:40:21.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnBbRSRc61y9aEJKXHUUE87usuLElcLPhscNifJ/GMIPdLPwi4eUN/kwmFyVcIQ9qW/GNy/E0QejSrWPZCa63nTFpFvcTwZmCMU/iqo6u8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10754
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 11:40:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11727

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U2VudDogVGh1cnNkYXks
IEp1bmUgMSwgMjAyMyA0OjI5IFBNDQo+VG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1J
RUMgT0RHIFBvcnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj50c2lwLmNvbT47IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+Q2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAg
VE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj50c2lwLmNvbT47IGhh
eWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw
77yz4peL77yt77yw77yUKQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPlN1
YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgMC8zXSBBZGQgZXh0NC1mcyBpbWFn
ZSBpbiByZXByb2R1Y2libGUgY2hlY2tzDQo+DQo+T24gMDEuMDYuMjMgMTI6NDMsIFZlbmthdGEu
UHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+Pj4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2Eg
dmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPj4+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEsIDIw
MjMgNDowNSBQTQ0KPj4+IFRvOiBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQ
b3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+Pj4gdHNpcC5jb20+OyBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPj4+IENjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRN
SUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+Pj4gdHNpcC5jb20+OyBo
YXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8
sO+8s+KXi++8re+8sO+8lCkNCj4+PiA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4N
Cj4+PiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlIDAvM10gQWRkIGV4dDQt
ZnMgaW1hZ2UgaW4NCj4+PiByZXByb2R1Y2libGUgY2hlY2tzDQo+Pj4NCj4+PiBPbiAwMS4wNi4y
MyAwOTozNCwgdmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+Pj4+IEZyb206
IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+Pj4+DQo+Pj4+
IEhpLA0KPj4+Pg0KPj4+PiBUaGlzIHBhdGNoIHNlcmllcyBlbmFibGUgZXh0NCBmaWxlIHN5c3Rl
bSBpbWFnZXMgaW4gcmVwcm9kdWNpYmxlDQo+Pj4+IGNoZWNrIENJLCB3aGljaCBpcyBuZXh0IHN0
ZXAgYWZ0ZXIgdGFyYmFsbCBpbWFnZXMgYXJlIGJlaW5nDQo+Pj4+IHJlcHJvZHVjaWJsZSwgbGV0
J3Mgc2VlIG5ldyBpc3N1ZXMgaW4gQ0kgYWZ0ZXIgaW50ZWdyYXRpbmcgdGhpcw0KPj4+PiBwYXRj
aCBhbmQgY29udGludWUgdG8gZml4IHRoZW0uDQo+Pj4NCj4+PiBDYW4ndCB3ZSBhZGRyZXNzIHRo
YXQgZGlyZWN0bHkgdmlhIHdpYz8gVGhhdCdzIGEgd2F5IG1vcmUgY29tbW9uIHVzZQ0KPj4+IG9m
DQo+Pj4gZXh0NCBpbiBJc2FyIGxheWVycy4NCj4+DQo+PiB3aWMgaW1hZ2VzIGluY2x1ZGUgcGFy
dGl0aW9uIHRhYmxlcyBpbiBpdCBhbmQgY3VycmVudGx5IGRpZmZvc2NvcGUgaXMNCj4+IG5vdCBj
b21wYXJpbmcgdGhlIHBhcnRpdGlvbiB0YWJsZXMgaW4gdGhlIGltYWdlcyBzbywgSSBhbSB1c2lu
ZyBpbmRpdmlkdWFsIGZpbGUNCj5zeXN0ZW0gaW1hZ2VzIChleHQ0KSBpbnN0ZWFkLg0KPg0KPkJ1
dCBJJ20gc3RpbGwgbm90IGNvbnZpbmNlZCB0aGF0LCBpbiBvcmRlciB0byBmaW5kIGEgZmV3IHR1
bmFibGVzIGZvciBta2ZzLmV4dDQsIGl0IGlzDQo+d29ydGggdG8gc2V0IHVwIGEgY29tcGxldGUg
c2VwYXJhdGUgdGVzdCBwaXBlbGluZS4gV2hhdCB3b3VsZCBiZSBuZXh0PyB4ZnM/DQo+YnRyZnM/
DQoNCkkgYW0gbm90IHN1cmUgd2hldGhlciB3ZSBuZWVkIHRvIHZlcmlmeSBhbGwgdGhlIGZpbGVz
eXN0ZW0gdHlwZXMgYXMgcGFydCBvZiBDSVAgcmVwcm9kdWNpYmxlIGNoZWNrcywgYnV0IEkgdHJp
ZWQgdG8gY2hlY2sgd2hhdCBhcmUgdGhlIGZpbGUgc3lzdGVtcyBhcmUgdXNlZCBpbiByZWZlcmVu
Y2UgaW1hZ2VzIGNyZWF0ZSBieSBDSVAsIG1vc3RseSBhcmUgZXh0NCBhbmQgc3F1YXNoZnMgZm9y
IHNlY3VyZWJvb3QsIHNvIEkgdHJpZWQgd2l0aCBleHQ0IGZpcnN0Lg0KDQoNCg0KPg0KPkphbg0K
Pg0KPi0tDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVk
ZGVkIExpbnV4DQoNCg==


