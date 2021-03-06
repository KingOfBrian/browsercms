#
# A group represents a collection of permissions. Each User can be assigned to one or more groups, and the sum of
# their permissions from all groups combined represents what they can do.
#
module Cms
class Group < ActiveRecord::Base

  GUEST_CODE = "guest"

  has_many :user_group_memberships, :class_name => 'Cms::UserGroupMembership'
  has_many :users, :through => :user_group_memberships, :class_name => 'Cms::User'
  
  has_many :group_permissions, :class_name => 'Cms::GroupPermission'
  has_many :permissions, :through => :group_permissions, :class_name => 'Cms::Permission'
  
  has_many :group_sections, :class_name => 'Cms::GroupSection'
  has_many :sections, :through => :group_sections, :class_name => 'Cms::Section'
  
  belongs_to :group_type, :class_name => 'Cms::GroupType'
    
  validates_presence_of :name
  
  named_scope :named, lambda{|n| {:conditions => {:name => n}}}
  named_scope :with_code, lambda{|c| {:conditions => {:code => c}}}
    
  named_scope :public, :include => :group_type, :conditions => ["group_types.cms_access = ?", false]
  named_scope :cms_access, :include => :group_type, :conditions => ["group_types.cms_access = ?", true]
  
  def guest?
    group_type && group_type.guest?
  end
  
  def cms_access?
    group_type && group_type.cms_access?
  end

  # Finds the guest group, which is a special group that represents public non-logged in users.
  def self.guest
    with_code(GUEST_CODE).first
  end

end
end
