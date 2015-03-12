React = require 'react'
{Link, State} = require 'react-router'
_ = require 'lodash'

ProjImgs = require './projectImgs'
ProjectIcons = require './projectIcons'
Blog = require './blog'
SpruceUps = require './spruceUp'

module.exports = React.createClass
  mixins: [State]
  render: ->

    pid = @getParams().projectId
    projectIndex = @props.projectIndex[pid]
    if _.isUndefined projectIndex
      msg = "Project (#{pid}) not found."
      return <h2>{ msg }</h2>
    projects = @props.whatwedo.projects.contents

    {title, images, prevId, nextId, content, catIds, blog_tag, spruceups} = projects[projectIndex]
    prev = projects[prevId]
    next = projects[nextId]

    <div>

      <div className="row project">
        <div className="col-xs-12 col-sm-8 col-sm-offset-2">

          <ProjImgs images={images} title={title} />

          <h2>{ title }</h2>

          <div dangerouslySetInnerHTML={ __html: content }/>

          { if spruceups then React.createElement(SpruceUps, spruceups) else false }

          { if blog_tag then React.createElement(Blog, {tag: blog_tag}) else false }

          <div className="icons categories bottom text-center">
            <ProjectIcons catIds={catIds} />
          </div>

        </div>
      </div>

      <div className="row minus-top controls">
        <div className="prev previous col-xs-6 col-sm-2 ">
          <Link to={prev.url} title={ prev.title }>&larr; Previous</Link>
        </div>
        <div className="next col-xs-6 col-sm-2 col-sm-offset-8">
          <Link to={next.url} title={ next.title }> Next &rarr; </Link>
        </div>
      </div>

    </div>
