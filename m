Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E4FC25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:22:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.79022.1717406523039084438
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:22:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4539M1eJ2653501; Mon, 3 Jun 2024 18:22:01 +0900
X-Iguazu-Qid: 2yAbAhOadL7VstdnIl
X-Iguazu-QSIG: v=2; s=0; t=1717406520; q=2yAbAhOadL7VstdnIl; m=bWfb0skkJV3HUZ17VkMReR51xWdF0Otbo98xZ/V+EoM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4539LxII1275290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jun 2024 18:22:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiRAinIxuv1FzDNre7UPF4SbwBi54yHDbO1Tl9XYAruQ/suJrp4U3jb0NrO2EKVnDqNlqznIqOskQFDUeMBmCZ/6hECvH9ZW8ECr1dBoYGMWOaRHks1UhR/s2W2lMWL6NZRMcof+lQNSg0LWoj6cU5sR04dOP0df6L5n9Epmw7FftU9HBCMyl39tKO11L4sRISnTlusFuaYzvRgU97fK/+qtD1UdwvXzSYd4vTKL6IjXIXllHtGmpVTCvwgoH4OXK0jvHakcMb73DnyOq2RqE0iICcBDlQcPIpGKMi2pL3k5yGk3vRTcWD969KjAwc+1x6m/62m0ipKvY9c6oLAx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCXV5jAYW+ZKAf2za9G6MgPj1DQvhlwqkXqbkFS+PCk=;
 b=X0j3Ogbyf9sb4vri+JrohOU8R77VrLFeNHV/9HnyYuZeH8j2RSxA+NxgLwXBYzTCbHtKML6GILFD0efwsK+Zzcp0bE0ajpoew+vP+eBU6Gwrl9ygsInky+x0QsNSp6XEqvh2wR8FOydfOA0fVsZYZ1zw+uJwknGaSrm8NliyOyfklLV6xbRdPL+zvBZ+FJUo0NqQxbX9hyLVpHOGE9lX0Dq9j/y8uAWb23rgz/isZgKDhj7r0rJhqmSHGGjnwODhFrQ+kasQXmF5E8jLbHZDd51Q27s2DK3Tp8XOYv3kY3mZxX1xdp9Q80svlLZySL4uftJ3z2RDPetDjLkrY5ytmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 0/3] Trigger CIP Core testing LAVA jobs
Thread-Topic: [isar-cip-core 0/3] Trigger CIP Core testing LAVA jobs
Thread-Index: AQHatYT1UTtbQzMJIkCCRVrZUVPOZLG1wEOAgAAAyUA=
Date: Mon, 3 Jun 2024 09:21:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610338EBD0DEC2E61E8CBD55C2FF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <9f1638f8-2f94-4b3e-bc3e-4871f83c6146@siemens.com>
In-Reply-To: <9f1638f8-2f94-4b3e-bc3e-4871f83c6146@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB8459:EE_
x-ms-office365-filtering-correlation-id: b8653ec4-c758-4709-cbd0-08dc83ae9cc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Z2VtckxqckV4U0g0aVplYU9kVlVyeFNqQUprY3pPK2wwOFh1Y0ZpR2l3?=
 =?iso-2022-jp?B?aStaV0VvalorT3RLU2RLTllHcFhlMXpJWkYvbDFORGNOVGNuQUZQUlJp?=
 =?iso-2022-jp?B?em5kdEdpMVUzamFoUm5OVHpXVFlwSnZiUzY1K0ltdXk3SEtDV1p0SSts?=
 =?iso-2022-jp?B?R1JmRHdMcTFkaHhhSHkvOHFpVnUxRzdUR3AvNHBWUGtMcmViNUlkR09a?=
 =?iso-2022-jp?B?NldhMjN6UTl4bWxEMzNnaXVPWVVkMGJGOGsraUJ0ZHFUMVE2ZFl3OFV5?=
 =?iso-2022-jp?B?M2dDVmU1TXAvUGs4c1hyVC9oNU9HN0NJWmJBeE5tTjc0dnpRc0RueUg0?=
 =?iso-2022-jp?B?SlZWdXJDZ1RYc0VHZUtCZzBENlJpR0x3UUtCVC9JSlJteTlvbWJUVjh3?=
 =?iso-2022-jp?B?ZE9NMWlPREhUY1VvajVmRTJWVzM5enR5eURrR3NwYkRNcHVkVHc0QkpL?=
 =?iso-2022-jp?B?aVM3MUxLN2N6S1krM2R0RTVRalFNVDRkVkJUOFlsWkJIMWFDMHJ4d1oy?=
 =?iso-2022-jp?B?ZVhPYTJVTzY3N1hlRG9ySFIvNUhETS85RXJGOGdGYXFNN2NyQ1JOVzl5?=
 =?iso-2022-jp?B?ZTNya1dOcTFSMlc3WWxqcWpraXN1dlVEbXIxNGtSWG1HWlc2VTQ4NzV5?=
 =?iso-2022-jp?B?U09aYkc2a1drSjRiZXNVKzIybWUyOGtsOE1XVXBxRHlqUlVRZjNEeGsy?=
 =?iso-2022-jp?B?LzdnYTNJam5nSEZ0L1hoS0pZSmI4dWJhZllzRFpTakpaQ2FpZmJQRUts?=
 =?iso-2022-jp?B?QU42MTZiWDQ5bzRJWFFxUVJQTkYrQmZiRStCWWNkUHJQRzMyVWt5YkJq?=
 =?iso-2022-jp?B?d3ZuMFd2M3AwbWNJbFdWWEp3VTgzSUZKS1c2SlJEREZJdE1UNnJHQy8y?=
 =?iso-2022-jp?B?SERJYVdEQUVYRWMyNklpSmVXbkRhM2lBalovV1Y1bGxNZitBMkFuRUFv?=
 =?iso-2022-jp?B?SjZJMXBucU5jS3BIWXlJN0RBem1Ld2RnMkRTR1Q4RmVSaUVpUkFVQlZN?=
 =?iso-2022-jp?B?MzBLMlMyb08xaER6bEJ2SklPNkNuTFpjSE1sM2t4YWNSYWlmVlc1a3lm?=
 =?iso-2022-jp?B?MXZuUUtPWU9ESXJkOVVNTkcwbzFITVdLNWNjTTNRbzNwaElhZVhJaC84?=
 =?iso-2022-jp?B?OHpkOWlXOGNhSUxQdndzNDFGem1KWUlSODhmQTFYM3lmL3R2Tm5BQ2N5?=
 =?iso-2022-jp?B?R1VPc0h4aS9xcXBmMWp3YW1tN1oyR2pSL01MUzFNUksyb3hQUzN3aWNP?=
 =?iso-2022-jp?B?U2V6b3czdStzL29wY3VFbXhacjE1c1dHczZuNXA4LzdFWk1jcTVKWmRo?=
 =?iso-2022-jp?B?VG9VemhyVXFTdE0xV0p4QW85eTZsMGVtbEZpeVVDYTY2R0VyY3Vrd1d2?=
 =?iso-2022-jp?B?MnZEdmVVamsrajdRbEdlUUxScFlWTDBWNTlPOGVadFU2d0VOVjRTTlp0?=
 =?iso-2022-jp?B?UUhXRTVlYkMzTGthZnAyeTA0d0NscGJ4dnZVWmlab0grOE02YmFvVUND?=
 =?iso-2022-jp?B?L01Wa3lLVmE3bzE2bU9nM0hHYkh4Q2swQlJLZFBoN1dCbGVOeUZhWDZa?=
 =?iso-2022-jp?B?S0Vyd2s1OTVoNkhWc2RYMnpOZzNCdFMrZzF2WUVpeWRtZFF6cGwyTHRB?=
 =?iso-2022-jp?B?WWtkcU1nc0Y4RjNNWWU0RlRlRzNkd0pLSndxZ3VMZThuNE5vU1JPeE1j?=
 =?iso-2022-jp?B?SWxYbC9jdkYyZFFxY0EvRFRBSkV2UWZ2bDE5SGMrT2JhejhTWEJxZDZY?=
 =?iso-2022-jp?B?dXM1eEVJM2JUNVgxWVRGeDV4K0tmdENiaXduMjJKbXFyR0plUENlRTJ1?=
 =?iso-2022-jp?B?RlVhbnUwMGllSEsrWml2OGJPYVJWRFBPbHhBR2ZVcHBocUdqY3ZtU3VR?=
 =?iso-2022-jp?B?YzA2OExETTE3N2pjRlk5OEFtNEYvQU9zZHk4ejY0TnBQZUMvNU9UUDRs?=
 =?iso-2022-jp?B?N05Kc3E4elRPei9wdEdRM2NuUm81Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZDh0c3RKYzhqMlFrTytKcnVsVVBnMDgxZVZqRGQzcW5nWi9oUjhUekwx?=
 =?iso-2022-jp?B?STJOR2tISnVNWktVR3BpWnJHWXh0cjdNc2xtZHRDV2J1K3JHUUNDaGZ5?=
 =?iso-2022-jp?B?eUVjL2QxMTVCTnJ0THFZUFBVNzVaMkV0dC9YZmU2WWMvYWkxVktuV0lr?=
 =?iso-2022-jp?B?RVlydGRyTDVPZkJpWU8zcERGdk1CNXd4d08zVFZyYkVSSnlXZHlOT1Jk?=
 =?iso-2022-jp?B?dUVvN2lRcmZ6STlGdWU5bnBRck5QS2dEcGhvNS91ZG1XYXVGYU1NdVUw?=
 =?iso-2022-jp?B?UnlpTE8wWEFWOVBQMGpFSnlYSktmaE9POFJUeUlLbTBYdUNsOHdFUDg5?=
 =?iso-2022-jp?B?RXAvaWsySEZpU200R3BscXVXSE8rRFFiVWxvY015N2h5ZTEyMXN5RDRK?=
 =?iso-2022-jp?B?U2FXbWs4VStjVEp1bVUxWjlVaTYxTzYyZkJzSk1jcG9vMTRlZ0ovQm1G?=
 =?iso-2022-jp?B?dnpBYUk2V0sxRzdMTUdvT3BjeHdSblJpdEFYM0NpUEF5czBpcmZ1N0Vk?=
 =?iso-2022-jp?B?TGdqYzlRcjVCY2hwU0hsN21hR25PcGxwSTlQYnJVcmhPNXFDa1VpUldi?=
 =?iso-2022-jp?B?U0JJMjMzR3R6M1RPQmdmVDJraUd4aEFkZmVJQXJlVXNLT2V6MWQ2ZlNz?=
 =?iso-2022-jp?B?SUltTTltS0hRa2Vta1djRXUwdC9GL2dCTS9oa2xxUDRCcWd0d1c2UXcr?=
 =?iso-2022-jp?B?enRDVHcydTd1enZ6cTBHMnF1eDBGNnZPRkR0THoyQlVud0taaFR4YzhT?=
 =?iso-2022-jp?B?bVNzYlhRZzU3eDYwOWhubDliRGNwVWpjcVlpUXAzaXVRWGJBT3FkejhW?=
 =?iso-2022-jp?B?eGswbmtpL1BweldiQUEyQi9mWWt1ZVJVd04rRTgwZVNKNXl0Y3dEZndH?=
 =?iso-2022-jp?B?U09Od1FlS1NDNlp5aytsR0NnSEtpbHRMMjcxN2NRQXJtL3dWVWpoU1U1?=
 =?iso-2022-jp?B?ejhJOWZGOFNrR3c3ZTFxZER5U1NQV1R3WWRnYWRGcnpPd0doZW9hU3Ar?=
 =?iso-2022-jp?B?QlRGS2xtNmhxWXFuNWhid2ZZUzMrNnBFRE9GRUZ2a2d6WE1PanpOM2kr?=
 =?iso-2022-jp?B?cDdobkFKd2N4YnZxWXM3NUhOWllneTIzbkd1M0NyTW9rdzlidGV2aVdh?=
 =?iso-2022-jp?B?ZHUzdFUwUFhJbVd3eE1HV2VMZE1jUmFPNjFEMFdsN21xdE9XT0xiNE5j?=
 =?iso-2022-jp?B?WXdvdUdtZ3JDNEw5bjFycjNtUUptSTEzWGpmY0ozeDBFajA4dWdiWEtZ?=
 =?iso-2022-jp?B?UGp2RGxTS2M2cTJKekgrVVVnaVgzN1lUYzJqNUlRWVVHY0VXakc3bjdj?=
 =?iso-2022-jp?B?VWh4WmhHa1c5a1c5YUhnWDBreTRITlpHTnh6V2EzN2FKd0ZzcERhbUJB?=
 =?iso-2022-jp?B?ZkFFMFNxT1JycTJPQTJOVXluTkMwK3pRUk92QjhkS1NPMEtmT1BBWTRW?=
 =?iso-2022-jp?B?dXdmcjd4Z0FDcG92LzI3d2NvU0JDQ2ZzaVU1WjhpbVV2aW1KdzVueDdR?=
 =?iso-2022-jp?B?MStDSmdBOUNDNHU5ZFpTcE1YMmx2Qmo5M1k4UG5uTmNNMm9FMThLWFZR?=
 =?iso-2022-jp?B?TlhRZ0N1QXcvdXFHMGdjNDNlRURTZ2NTQitUU01za0ZUN0VxZ3ZnTXlV?=
 =?iso-2022-jp?B?SW1lNmR3bkNlZUo4SStMZHJ4a1pmdU9jdHBpOVNwWWJoRHU5WTN6dWRa?=
 =?iso-2022-jp?B?anBVMVRZbjhrZ2ZCWEl0QkJsb1gzSW5xZHUwNEZtM21GM3U0VUJxRXNz?=
 =?iso-2022-jp?B?aXduekdtdjRTaVFRUDYzdzBTb0xjbHE4Q3NPdDQ0WUJqR0dEeDIxdysw?=
 =?iso-2022-jp?B?dDRoOEQxYlVVeXFTQys1UWpremt3N2lWZEdFdW8xM2U2NDNXWG1oeUlo?=
 =?iso-2022-jp?B?OWlYS0lKbmx3aG5nSEZGcm9UK0tPR29tUEpmMFQra3NDRENDVldkV0NQ?=
 =?iso-2022-jp?B?aGprMlhOYWVjU2hnZzhLRWExSFJhc3ZUUG9MWURGYkhWMWlLcEpJQWtX?=
 =?iso-2022-jp?B?eHo4L0ZXQnlEbnY0U1BLS0kvU05LSG5BRDlzbUlsWEI2OENTbld0UXZT?=
 =?iso-2022-jp?B?cHFGbnJlU0NuWjJxbEhDaGdyU3g3ZFJMMmxUUE1KMlUzQ3ZEZzFGRThX?=
 =?iso-2022-jp?B?MFcvK3F0bGdFZnR5Y2pBeVZnd0RxMzduTVk3dFE3TVpRSXRDOERZU1VC?=
 =?iso-2022-jp?B?cHhqdWtTQzlLcDN6Q00wTkV0MEptYlFNL3pPYUFLM2RBajc3N1JSSHdw?=
 =?iso-2022-jp?B?NnZHdUNGbDN4TGZ1TllkenU5UnJjc0lZWjhLREdGZ1h6VXhRRmZHSmV1?=
 =?iso-2022-jp?B?RENVc0M5aDlsRk1EZ3MwTFgxa21tRHY0ZFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8653ec4-c758-4709-cbd0-08dc83ae9cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:21:55.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4eJI6q8Rbj4zS5Boyps0c1qxk+TPd5IFP69nTb8HUboB/+fal0K20yRhNFFNohtOmsTqdFPK/HUXG0Kztt5cxHhY299pB/nURSy3m4r/Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:22:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16090

Hi Jan,

Once these patches are applied, every pipeline triggered after that will tr=
igger 3 test jobs which send 11 LAVA jobs to CIP LAVA Lab testing secure bo=
ot, Swupdate and IEC Layer. Currently siemens and cyber trust LAVA labs nee=
d to be updated so that these jobs can run there. In my opinion it is bette=
r to consider merging these patches once LAVA Labs are updated. I reminded =
Chris to ask the maintainers of those labs to update them so that we will h=
ave at least 4 QEMU devices capable of running these jobs.

Thanks and regards,
Sai Ashrith Sathujoda

-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com>=20
Sent: Monday, June 3, 2024 2:39 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; cip-d=
ev@lists.cip-project.org
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core 0/3] Trigger CIP Core testing LAVA jobs

On 03.06.24 09:09, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>=20
> This series of patches will trigger LAVA jobs which test swupdate,=20
> secure boot and IEC layer.

So, if I apply all these to 'next', what will happen, what can I expect?
I'm keen on getting these in before the release to have that validated, but=
 I'd like to understand where we are in this regard and only rush if that a=
dds value.

Jan

>=20
> sai ashrith sathujoda (3):
>   test/templates: Include functionality based templates
>   submit_lava.sh: Add script to submit the jobs prepared from templates
>   .gitlab-ci.yml: Add test targets specific for CIP core=20
> functionalities
>=20
>  .gitlab-ci.yml                         |  33 ++
>  scripts/submit_lava.sh                 | 458 +++++++++++++++++++++++++
>  test/templates/IEC_template.yml        |  72 ++++
>  test/templates/secureboot_template.yml |  63 ++++
>  test/templates/swupdate_template.yml   | 123 +++++++
>  5 files changed, 749 insertions(+)
>  create mode 100755 scripts/submit_lava.sh  create mode 100644=20
> test/templates/IEC_template.yml  create mode 100644=20
> test/templates/secureboot_template.yml
>  create mode 100644 test/templates/swupdate_template.yml
>=20

--
Siemens AG, Technology
Linux Expert Center


