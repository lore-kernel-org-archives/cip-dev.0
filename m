From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 06 Jan 2017 12:57:30 +0000
Subject: [cip-dev] CIP update 07 WK 01
In-Reply-To: <87a8bo0y12.fsf@codethink.co.uk> (Robert Marshall's message of
	"Thu, 22 Dec 2016 15:43:53 +0000")
References: <87a8bo0y12.fsf@codethink.co.uk>
Message-ID: <87a8b4e479.fsf@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


* Virtual machine creation for the testing
  We've created 2 vagrant instances one for kernelci and the other for lava
  (lava is Debian based and kernelci is ubuntu based) work is in
  progress on merging these to make developer setup simpler and reduce
  the memory requirements.
      https://gitlab.com/cip-project/testing/issues/7

* There's a github branch to allow the host to view the kernelci vm webserver
  https://github.com/RobertAJMarshall/kernelci-frontend-config/tree/external-http
  this will be merged with the gitlab repository when
      https://gitlab.com/cip-project/testing/issues/3
  has been resolved.

* The DeviceDictionary error 
      https://gitlab.com/cip-project/testing/issues/5
  is still outstanding

* Devices have been added to lava VM but are not yet running
      https://gitlab.com/cip-project/testing/issues/9

* the lava gitlab and the vagrant instance now has been updated 
  with health check tests and extra documentation.
  
* The QEMU health check results in a KVM module not found failure
      https://gitlab.com/cip-project/testing/issues/8

* Discussions in progress on adding a 'howto'
  The developers have a document enumerating the steps involved in
  getting the testing environment up and running, this document will
  be streamlined and published to the wiki. Meanwhile, we will add the
  WIP content to the repository so you can follow it.

* Minor additions to the wiki has been made, specially in the kernel
  maintenance page.

Robert
