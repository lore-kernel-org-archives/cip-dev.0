Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F24C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 10:06:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.17418.1718791571635965372
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 03:06:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 45JA68T81314150; Wed, 19 Jun 2024 19:06:09 +0900
X-Iguazu-Qid: 2yAbLYkr6j3p6Ltr0M
X-Iguazu-QSIG: v=2; s=0; t=1718791568; q=2yAbLYkr6j3p6Ltr0M; m=uQlYox5LBOECadLkUHkUUggV0b+mZE72M7z4xZfFkMk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 45JA67m32949096
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 19:06:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFGSt8YySv8eV9szEQaJjAGyDiHgNhrPYCDqeBZH6yLKAZ+R3BwjBUue+3BxYASkrCkAiOyTouLBt4xysuvfh+WmdVK9V6gDGGHSgmuyVAPEusCwSxLo2s+RyQ8Nw/Avaxg+KmQ6VjE6BeD/1OrBRzoFTR2br8A+vMv1n6YIQZm4MKPN8v9Y4H3c4BT6BcqyLoLAIiN0RaCmf+DooL3A/kV7CyNE4Ean9KoFjiTsV+Cy7JgT07SOPerUdOPszWq83ORutdECjweHm+mbNL6byrscvduHPJl4g6K3SbLYXlhtlbRdklOacJNF+9Gyzah2ftLHhgq/F/HdaQpwoZhgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfS8BSo9TOZMT956TWM7YkFzniDBQeBeE6oJA14J92Y=;
 b=SQ5jQZU5MUwMqZtqqkku8KR69o7dEAAlPcTJX3SFssdPQYoVzvuGi3c9GlD+U15eVKHIGb5xYb42AeQqT+PxuRykcPAhjeeGvt8kJoK7RSHYV7hZgxdriQxOQubBoBhGT481Ky6piSUBtKt0jy6oi43BBrJQgED3WLsH+opuqn5V8fS9c3WMHLSEw8DrOx/gkqFmZvRwzoEORIariR9fLQ07NnqfJsn7lt1hEuJkM6Dl55XvA0uozYp1Ohnft+AJ8hYmCEgQC3p99pVh07qpfWTI6vVmm4IdgNJ44QkRTQnd8itbp/M9FyYVmiUNIdQX6zKt98TEHwV0+K+T1fXUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: MCOM device testing status
Thread-Topic: MCOM device testing status
Thread-Index: AdrCLbeQi0Gg2eBfT02xZu9XbekTxg==
Date: Wed, 19 Jun 2024 10:06:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075D40AA8B013BAF6DED310C7CF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYWPR01MB9359:EE_
x-ms-office365-filtering-correlation-id: 1cbb040a-51b6-4b41-36a3-08dc90476ed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Q2I1aldvZyt0RUcwY2plSy8yR0J4cU5tei8zTnRmS0xEcXhPbVJReU1v?=
 =?iso-2022-jp?B?c3JKZlVRSVc2Qlp1S0x1Qk82RDdrT3cxWmRNMEpmR0x5eWJ0SEl6aHZx?=
 =?iso-2022-jp?B?SmQ4NVBqWW9za0ZPdHJOYWRIMFJhRnhsRmpXSllIZHhObVBlWUFXQ3lE?=
 =?iso-2022-jp?B?V2xaKzIwUG80SEd0NnZJYTRwOGlIR2k5ZnVQMWF6Wlo2Vi9MZDNrVWdJ?=
 =?iso-2022-jp?B?emppVVBuQ3pyQWw0NEVQTzJTR1NJQTgrbm5qZEVyYVF0dkEzQzdUQ2xP?=
 =?iso-2022-jp?B?WGdOY0wrc09VWENjN2FqK2lDSEQ5YTF4cEw1dnl1cWk5UCtJSlNBNi82?=
 =?iso-2022-jp?B?MzRkRlcrcW9kSElmaHVXSUdON1ZEbDVRSjFBQ053bnZHWkl1K0xRTzZX?=
 =?iso-2022-jp?B?YkNOWWZ6dmF1d1UwbkFCdEJZVCtNaHFwazZBUmtiSkZmUjNWdEYyNTlR?=
 =?iso-2022-jp?B?SHhDakhzVWRuT1ZMZVM2WktHN1NGZ29GTHYzWTV0eG9kN0szUGJUQkRE?=
 =?iso-2022-jp?B?T3EvTnQrMWt6Q28yQmhPMExNSjRKUlVSd1pkZjdYQlNaRmE1UEh6MHkv?=
 =?iso-2022-jp?B?cXNRVHpUOW9NZUJtaDBCSUVWWEZ3NkdtTU55clJHSGgyYy81R3R4alZM?=
 =?iso-2022-jp?B?UDNnb2locjlTQTR1cURYQlIwTmdWYjJjNFZ5ajNUVVE1UGdNOWFPNVpS?=
 =?iso-2022-jp?B?TkFPbzQ4Tm1aQzlQKzBjMExxa2EzMndrNVZIRU5pTnB2Z1pYTzlNcDBN?=
 =?iso-2022-jp?B?c3FnRjVPb2JGUjNkZnY5cXNYMU10a3FhR1FXTHJ3ZERUaThOMHFZdDRE?=
 =?iso-2022-jp?B?RTA0ZTVDeThnUFNkWC9uNGpxV3U1UDZHbFVPQWhva2pzNjlpUWNNb2dJ?=
 =?iso-2022-jp?B?VmdMQWpROXFsVzUyVVA3dllsTWUzZU1ERlhCaHV4OHMySXhmQnhkS1Rq?=
 =?iso-2022-jp?B?QnE2RnBndWxVMHdabHIxdG02WnMzNkhvR3h5VnJWc2pLTkpxaVgreFRI?=
 =?iso-2022-jp?B?YjYwMjJmbFhKckEzNzZsQkZMZUlIajZQeitvOENkMVdVNk1Hd2szVy9T?=
 =?iso-2022-jp?B?MnQwb0RlMDJzMytkWFNiWEluSWlQZEFiUFhsK0wyYVZ1Z1FLUXBMRWFR?=
 =?iso-2022-jp?B?MmVzcnJzdnQxbnRDcmlob1FzcG1NR1pYTnBLUFRzNjcyWURxZU04M2dC?=
 =?iso-2022-jp?B?UFFBamt0bmJLQmJlaFd3SnJNV0R6bXV3VEVUZXBMV0pKNnh0YmZYK21I?=
 =?iso-2022-jp?B?Z0lwczgyVmVDTlJOL0s5VjJUSXZMZFZseW1ySVFlUk53eGt4M0FqTTJk?=
 =?iso-2022-jp?B?ZUhVYnBzWjJUVnFpcDVpSU1yWGtwWU9rVXpTeXQ1RXJpbWFSQnBRU0lD?=
 =?iso-2022-jp?B?ZjhrSzVKQ21FVjY1SGZyNTA1dEVOM0xWMlk3ZUY3cG9jOGlxOW8rVldR?=
 =?iso-2022-jp?B?cHE3d2FCdE5vOGhTeTVWSVU0VHRZSS9LVGJMWlRwK2FaYVVGSDJmRzFR?=
 =?iso-2022-jp?B?RjFYTTY1SUFyUGZiMDVPVGlqNncwY2ppM0c4R0JCWGpyN0NWUlVCU0NN?=
 =?iso-2022-jp?B?c1ZOcXR1c2NKRFU0dXIyRlJCNTd5cVp5UTFrNmtCMDhVdTQzdnpJVFYr?=
 =?iso-2022-jp?B?bExaeE03eTV4YXU2U3lOMWFpV0VWT29wazQ4VWFaVzJuZmIwZTl3YmlP?=
 =?iso-2022-jp?B?a2NXUS9Zc0I2UmxhVDF5V050VDNnWGRFSVFrN1VsaTVLMnJpVUpVaUFw?=
 =?iso-2022-jp?B?VFBYbVNLYkpVc3FPMFQ0MDVXY3N3R3lSTDk0VExhTzdFWXZOeUJqK1Rx?=
 =?iso-2022-jp?B?ZExOSW92RUJRQ1J2QUlPVkpmdTVCVUJ3azhMSVY2Mk45N1Eyak1KdDNu?=
 =?iso-2022-jp?B?c3R3VmlLQmdzM0VzZ1FTWVgxY2RSWkhiNXhYU014ZE1zQnlWM2twZ0R6?=
 =?iso-2022-jp?B?bTdDcXNjeGJVaGE0djZUa0Y3RHdpenVxVkhrakF4dGVGdFA0OGQ2aUlZ?=
 =?iso-2022-jp?B?Zz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K0MrNkN3ZGtnUkNmeFlDZm12OUVPOVNnUGo5V0dEcG9HOUQrZVVJdVh6?=
 =?iso-2022-jp?B?QVk4Y0JOVG9LcUFKMkZxc1AvYXVhV0J4a2UvY3hkZlVwMDltOUFpWjBv?=
 =?iso-2022-jp?B?NEtudFFITkM2RVFDT0xUYTFaV0JGTUpsaVZMZEZCQ3Z5YVpaT2hIQ2Jn?=
 =?iso-2022-jp?B?ZkpjOVFLbDVlMUtSM1ZUVlNEUW9iMzhmZEpuL09EaHFYVCthK3dBVUVQ?=
 =?iso-2022-jp?B?WkxLU1FOdENqei9WazNMdEwyRFU0TEdXUzRLQUlwd1RORDhMVHB1a1RS?=
 =?iso-2022-jp?B?K1lmNzJ1Vm9TQW4reEZldmhzaGJKbmk3MG9OcjR1UklhWVVuWllYbGhX?=
 =?iso-2022-jp?B?dmdqMlFXQWRqb0U2aG9sdnpOczgzb3dBV0JPampvYUZKUkd5OVZOVkFJ?=
 =?iso-2022-jp?B?aUxIWHF3V3ZDVHdWMnptVkQ5ZHlkdGszUmRDVzV5MmxlRW9TdXlDYWUy?=
 =?iso-2022-jp?B?QWdJMEUxNmtmakZabmJOcXpsVlBJbC9nQlVuN2l4dENKVDl4QXNnNUxp?=
 =?iso-2022-jp?B?ZUtpY0tzaHpiSEFmY0h1MTZWKytNL0gwbHk2QkludmhmOENoSG9qVjdO?=
 =?iso-2022-jp?B?RTRua3ozVyszVkV1VUd2bDl2Z21nZDFjd2lZNktxNVFFWVNpa2xoQ2Fi?=
 =?iso-2022-jp?B?VVBXbTN1b0huSWdZTVhqSGZzaitieHBWZ0ZWaGxGZzZpNjR6ZWtuQlg3?=
 =?iso-2022-jp?B?cjFjdnRueTYzVDY2bmJCNWJxRlB3MWwrRVBXaDJxdHZ0TWpUVEpDOWRU?=
 =?iso-2022-jp?B?LzVPS3owRkFJQXUzN2FtcUZJQ2ppejBiQ2l1U083WmhFWU0vbVgxa1U1?=
 =?iso-2022-jp?B?eXk1L0JwOTgvNmdQbmVHSlVzTktVbmFkaDJ6cFA3bkZSamxsTUtaYmFy?=
 =?iso-2022-jp?B?VTZ1MGl0RDNxQk1SV0xnVmV0dlJKVGtLYk13ZkFTQ05jcGo4VTR5YmMv?=
 =?iso-2022-jp?B?djNlbndld0xNVlFEVkQxQUFuZUtHTWl5RUVYK1NvcUwycVVKME82TVJi?=
 =?iso-2022-jp?B?YXFvSEZQaG0zZmwyU2kwVVpZZ1hnWFFZY21uaEdqTkFOUzErUXVCMC9k?=
 =?iso-2022-jp?B?Z0pOcTMzSGZucXo2akRQYVdHc0hPb3NsQWxFK09zTzd0OE1MMU1YbHhp?=
 =?iso-2022-jp?B?Ykx4QzZGL0dvQy9oNTlRTHhFckJ6bHBhZ1J0OHBoaUlkNFQrVlNzc3or?=
 =?iso-2022-jp?B?V3ljc2J0dFpaczFaOU5lRWhlOGF1SGFiYVI0TzBlWG1qUjJ1SlpiSG80?=
 =?iso-2022-jp?B?Y2RhT2pxYmVFdUkveHdTRHZnRWdHZ1FxeU53akU2b0FabVphcnp5SmY3?=
 =?iso-2022-jp?B?NW1nMTBBK3F4SkZqeEZnTkx0Z2paOU4wc1VJcjcrODNxZVJoVko2M3pM?=
 =?iso-2022-jp?B?SFBCVkdtRHhPU1ZyTlV6YkdHNytaUytHQjM5U1pnQ3R1S095Rml6TkNa?=
 =?iso-2022-jp?B?M1JNdXFUQmo4QmFtN2YvdUJkejRZNGRkQzJyK2tkRXEwQUVzTEVkQUVm?=
 =?iso-2022-jp?B?ZlNZSUZNUW9kVGhBaVVNSjZqa0ExK2NYTDVrdXBOSGg0Wmp3UVdyanE3?=
 =?iso-2022-jp?B?R1RhcTR2ZG83V05rRWVreXVEOExtMkZJd3ZGVGVIRG1BYy9NdklVdkoy?=
 =?iso-2022-jp?B?SGpGT3ZMSVJieDNFeFVKWCt2ZDVaUURlOWJqb3R4a25ySFh3SisyWVdR?=
 =?iso-2022-jp?B?STFsdDlrRjFnNHd4bWdTd0F0czJKWEVnQWlNVDFBRkV3d1NMTEo1Ykwx?=
 =?iso-2022-jp?B?azR2U0FreGJucWpWSkpIU1pFTG9CMjFMNWdqRG5WenB6RlJFRHhxTGhi?=
 =?iso-2022-jp?B?cVRJdy9pWjVJck4vN3RZUHlrNy9vakhVZ0thN2hxaFVDaWZVVEFHN0dB?=
 =?iso-2022-jp?B?dnBZYjYzbW9xbTJNREEzUERicEM3VHpDbFh4V2FHR1drYk53NUg1K0JM?=
 =?iso-2022-jp?B?aGQ4ZmU2RldRMDdzQUNuaFdSYWZ6MW5hZjQ2V0lPa1JTWGRwenArNzFr?=
 =?iso-2022-jp?B?V2FpYTA1SmZUT0orZjByWkZDejRsZ1dnY2pDQyswb3d5eG92aTdXTEJ3?=
 =?iso-2022-jp?B?elN2VWxnVUZMNVpFZTNzdDFOUGpNK2hVMk1kYThHUTV5aEs3YXdlYXht?=
 =?iso-2022-jp?B?T29yU1V1ZUl4eUFDaXpSY0JMamdIb2oyMzFVWlNNamF6OEl2aktoazNZ?=
 =?iso-2022-jp?B?R0l4SnZkL2JhK0dZWWJlUTlNTDI4MUdMUkkzcUpCbG11USt6WDBwbzZa?=
 =?iso-2022-jp?B?NzdDT0k2U1E5QTFXRllkZDhlaitNRkx6eVFRMVlIM2ZxQm9Rb0Nvd2Fz?=
 =?iso-2022-jp?B?bGJyWVdaTVMyV0E1eEQyMDkxT1FXcE9BV1JmbUZZcVZsdHRDeC96RUFq?=
 =?iso-2022-jp?B?b2lnc0preGF2V1JUQmsvQmJjRVFOWUIvZTlVY2JvTTFrQzdoTU1ocktn?=
 =?iso-2022-jp?B?YWRoZlEzQ1NGMFVNRWRIYkpsUk5oMTR2TS9ZPQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075D40AA8B013BAF6DED310C7CF2TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbb040a-51b6-4b41-36a3-08dc90476ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 10:06:05.5939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAKpz1zLpblPOfWPeOHmhHpFnjyJy/Pb+vIyiMQ7BlYkiqiT8Nqw4dqJF+tA37nxV1/mlnlY+yErZDXGs9EidthqZlR44Jij8vVlLf44FnsWZnfq34Ym6UFO1G69A9sF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9359
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 10:06:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16293

--_000_TY3PR01MB11075D40AA8B013BAF6DED310C7CF2TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

This is to inform you all that the generic x86 image created from current m=
aster branch is successfully booted on MCOM device.

Please find summary of testing so far,
Base generic x86 image:

  *   Boot successful

SWUpdate

  *   Confirmed, it works fine by applying swupdate.

Secure boot

  *   Build error in current master branch
     *   ERROR: /build/../repo/recipes-core/images/cip-core-image-security.=
bb: WKS_FILE 'x86-uefi-efibootguard-secureboot.wks.in' not found
        *   I found =1B$B!H=1B(Bx86-uefi-efibootguard-secureboot.wks.in=1B$=
B!I=1B(B file is not present in the repository so, locally copied =1B$B!H=
=1B(Bqemu-amd64-efibootguard-secureboot.wks.in=1B$B!I=1B(B file contents to=
 =1B$B!H=1B(Bx86-uefi-efibootguard-secureboot.wks.in=1B$B!I=1B(B and create=
d image for testing purpose. My understanding is that there is no differenc=
e in qemu-amd64 and x86-uefi wks files apart from watchdog settings. Please=
 correct me if my understanding is incorrect.
  *   After injecting the secure boot keys, the boot failed with following =
error =1B$B!H=1B(BInvalid Signature Detected. Check Secure Boot Policy in S=
etup=1B$B!I=1B(B. Investigating this issue is in progress.

Thanks & Regards
Shivanand K

--_000_TY3PR01MB11075D40AA8B013BAF6DED310C7CF2TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1669945212;
	mso-list-type:hybrid;
	mso-list-template-ids:-1675704966 1740295048 1074331651 1074331653 1074331=
649 1074331651 1074331653 1074331649 1074331651 1074331653;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;
	mso-fareast-font-family:Aptos;
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-font-weight:bold;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi All, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is to inform you all that the generic x86 image=
 created from current master branch is successfully booted on MCOM device.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please find summary of testing so far, <o:p></o:p></=
p>
<p class=3D"MsoNormal"><b>Base generic x86 image:<o:p></o:p></b></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1">Boot successful
<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>SWUpdate <o:p></o:p></b></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1">Confirmed, it works fine by applying swupdate.
<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>Secure boot<o:p></o:p></b></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1">Build error in current master branch<o:p></o:p></li><ul style=3D"marg=
in-top:0cm" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level2 =
lfo1">ERROR: /build/../repo/recipes-core/images/cip-core-image-security.bb:=
 WKS_FILE 'x86-uefi-efibootguard-secureboot.wks.in' not found
<o:p></o:p></li><ul style=3D"margin-top:0cm" type=3D"square">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level3 =
lfo1">I found =1B$B!H=1B(Bx86-uefi-efibootguard-secureboot.wks.in=1B$B!I=1B=
(B file is not present in the repository so, locally copied =1B$B!H=1B(Bqem=
u-amd64-efibootguard-secureboot.wks.in=1B$B!I=1B(B file contents to =1B$B!H=
=1B(Bx86-uefi-efibootguard-secureboot.wks.in=1B$B!I=1B(B
 and created image for testing purpose. My understanding is that there is n=
o difference in qemu-amd64 and x86-uefi wks files apart from watchdog setti=
ngs. Please correct me if my understanding is incorrect.
<o:p></o:p></li></ul>
</ul>
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1">After injecting the secure boot keys, the boot failed with following =
error =1B$B!H=1B(B<b>Invalid Signature Detected. Check Secure Boot Policy i=
n Setup=1B$B!I=1B(B.
</b>Investigating this issue is in progress<b>. </b>&nbsp;<o:p></o:p></li><=
/ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB11075D40AA8B013BAF6DED310C7CF2TY3PR01MB11075jp_--


