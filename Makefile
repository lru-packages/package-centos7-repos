NAME=centos7-repos
VERSION=1.0.3
ITERATION=1.lru
PREFIX=/etc/yum.repos.d
LICENSE=None
VENDOR="Lucky Rocketship Underpants"
MAINTAINER="Ryan Parman"
DESCRIPTION="Updated version of the repository file."
URL=https://github.com/luckyrocketshipunderpants/centos7-repos
RHEL=$(shell rpm -q --queryformat '%{VERSION}' centos-release)

.PHONY: package
package:
	rm -f centos7*
	wget -O centos7.repo https://raw.githubusercontent.com/luckyrocketshipunderpants/centos7-repos/master/centos7.repo

	fpm \
		-f \
		-s dir \
		-t rpm \
		-n $(NAME) \
		-v $(VERSION) \
		-m $(MAINTAINER) \
		--iteration $(ITERATION) \
		--license $(LICENSE) \
		--vendor $(VENDOR) \
		--prefix $(PREFIX) \
		--url $(URL) \
		--description $(DESCRIPTION) \
		--rpm-defattrfile 0755 \
		--rpm-digest md5 \
		--rpm-compression gzip \
		--rpm-os linux \
		--rpm-dist el$(RHEL) \
		--rpm-auto-add-directories \
		--rpm-changelog CHANGELOG.txt \
		centos7.repo \
	;

	mv *.rpm /vagrant/repo/
